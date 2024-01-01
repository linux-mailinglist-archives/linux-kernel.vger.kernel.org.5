Return-Path: <linux-kernel+bounces-13954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224A821589
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAF91F214D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093EE57E;
	Mon,  1 Jan 2024 22:29:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxout013.mail.hostpoint.ch (mxout013.mail.hostpoint.ch [217.26.49.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39706E556;
	Mon,  1 Jan 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-gloor.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stefan-gloor.ch
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
	by mxout013.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rKQc2-0008Ap-1b;
	Mon, 01 Jan 2024 23:18:22 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad)
	by asmtp013.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rKQc2-000Miy-10;
	Mon, 01 Jan 2024 23:18:22 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
Date: Mon, 1 Jan 2024 23:18:21 +0100
From: Stefan Gloor <code@stefan-gloor.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] hwmon: (sht3x) read out sensor serial number
Message-ID: <20240101221448.wtwn23vgeptgs36v@thinkpad>
References: <20231227190036.20725-1-code@stefan-gloor.ch>
 <20231227190036.20725-2-code@stefan-gloor.ch>
 <4389cd48-5d61-49bc-8cb5-b337afe40c23@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4389cd48-5d61-49bc-8cb5-b337afe40c23@roeck-us.net>
X-Vs-State: 0

On Sun, Dec 31, 2023 at 10:32:56AM -0800, Guenter Roeck wrote:
> This creates i2c<bus>-<address>/serial_number when the device is instantiated.
> That debugfs entry is not removed when the device is removed, only when the
> driver is unloaded. This means that de-instantiating the device will leave
> stray debugfs directories and files behind until the driver is unloaded.
> 
> We had this before, and I understand that you claimed that this doesn't happen.
> To get me to believe you, you'll have to provide a log of
> 
> - instantiating the driver 
> - Showing the debufs tree
> - de-instantiating the driver
> - Showing the debugfs tree
> 
> ... but even then I'll want to be able to test it myself. Not sure if I
> have an eval board, but either case that will take some time. Frankly,
> I don't understand why you refuse to remove
> i2c<bus>-<address>/serial_number on device removal.
> 
> Guenter
> 

Hi Guenter,

Thank you for your patience. As this is my first patch set for Linux I still
need to learn a lot.

You are right. I was confused about driver instantiation and driver
loading/unloading. The i2cX-XX directory needs to be removed explicitly.

If I understood correctly, the following changes should achieve this:

+static void sht3x_remove(struct i2c_client *client)
+{
+	struct sht3x_data *data;
+
+	data = dev_get_drvdata(&client->dev);
+	debugfs_remove_recursive(data->sensor_dir);
+}
+
 static struct i2c_driver sht3x_i2c_driver = {
 	.driver.name = "sht3x",
 	.probe       = sht3x_probe,
+	.remove      = sht3x_remove,
 	.id_table    = sht3x_ids,
 };

Of course data->sensor_dir needs to be set to the i2X-XX directory when it is
created.

If there is nothing obviously wrong with it I'll submit v4 shortly.

Best,
Stefan

