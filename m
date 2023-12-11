Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD580CF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbjLKPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbjLKPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:12:19 -0500
Received: from mxout014.mail.hostpoint.ch (mxout014.mail.hostpoint.ch [IPv6:2a00:d70:0:e::314])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F83D8;
        Mon, 11 Dec 2023 07:12:24 -0800 (PST)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1rChxB-000N76-1z;
        Mon, 11 Dec 2023 16:12:17 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad)
        by asmtp014.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1rChxB-0007q1-19;
        Mon, 11 Dec 2023 16:12:17 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
Date:   Mon, 11 Dec 2023 16:12:16 +0100
From:   Stefan Gloor <code@stefan-gloor.ch>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: sht3x: read out sensor serial number
Message-ID: <20231211151216.yehwa27daveq57jo@thinkpad>
References: <20231204165004.8491-1-code@stefan-gloor.ch>
 <20231204165004.8491-3-code@stefan-gloor.ch>
 <69065f64-1448-4513-bdda-a25a913e914d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69065f64-1448-4513-bdda-a25a913e914d@roeck-us.net>
X-Vs-State: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 06:31:27AM -0800, Guenter Roeck wrote:
> On Mon, Dec 04, 2023 at 05:50:04PM +0100, Stefan Gloor wrote:
> >  
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +static void sht3x_debugfs_init(struct sht3x_data *data)
> > +{
> > +	char name[32];
> > +	struct dentry *sensor_dir;
> > +
> > +	data->debugfs = debugfs_lookup("sht3x", NULL);
> > +	if (IS_ERR_OR_NULL(data->debugfs))
> > +		data->debugfs = debugfs_create_dir("sht3x", NULL);
> > +
> > +	snprintf(name, sizeof(name), "i2c%u-%02x",
> > +		 data->client->adapter->nr, data->client->addr);
> > +	sensor_dir = debugfs_create_dir(name, data->debugfs);
> > +	debugfs_create_u32("serial_number", 0444,
> > +			   sensor_dir, &data->serial_number);
> > +}
> > +
> > +#else
> > +
> > +static void sht3x_debugfs_init(struct sht3x_data *data)
> > +{
> > +}
> > +
> > +#endif
> 
> debugfs doesn't need if/else or error handling.
> 
Do you mean the IS_ERR_OR_NULL? I included that to get rid of the
"debugfs directory already exists" message when using multiple sensors.

Will remove #ifdef in V3.

> 
> > +
> > +static int sht3x_serial_number_read(struct sht3x_data *data)
> > +{
> > +	int ret;
> > +	char buffer[SHT3X_RESPONSE_LENGTH];
> > +	struct i2c_client *client = data->client;
> > +
> > +	ret = sht3x_read_from_command(client, data,
> > +				      sht3x_cmd_read_serial_number,
> > +				      buffer,
> > +				      SHT3X_RESPONSE_LENGTH, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->serial_number = (buffer[0] << 24) | (buffer[1] << 16) |
> > +			      (buffer[3] << 8) | buffer[4];
> > +	return ret;
> > +}
> > +
> >  static const struct hwmon_ops sht3x_ops = {
> >  	.is_visible = sht3x_is_visible,
> >  	.read = sht3x_read,
> > @@ -899,6 +947,13 @@ static int sht3x_probe(struct i2c_client *client)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = sht3x_serial_number_read(data);
> > +	if (ret) {
> > +		dev_dbg(dev, "unable to read serial number\n");
> > +		data->serial_number = 0;
> > +	}
> > +	sht3x_debugfs_init(data);
> 
> The debugfs entry should not be created in the first place if the
> serial number can not be read. On top of that, the debugfs entries
> are never removed, meaning the system will crash if the driver or device
> is unloaded and the no longer referenced debugfs file is accessed.

Got it, will fix in V3.
-- 
