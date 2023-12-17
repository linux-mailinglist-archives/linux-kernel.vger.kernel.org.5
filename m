Return-Path: <linux-kernel+bounces-2457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68791815D69
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F86E1C21670
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31E15BE;
	Sun, 17 Dec 2023 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi/usC7l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E22A40;
	Sun, 17 Dec 2023 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77f3159d822so157769485a.2;
        Sat, 16 Dec 2023 20:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702789197; x=1703393997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+UltNrsyGWSVcT46lR5ejKknw3QMITEfIA00sFphM4=;
        b=Mi/usC7lhKQluoYFi9oF63FIbqrEhrIG4c3R/pMFIDTEesgq4+N1haW7usWHbDr9nA
         MgyNDmObZQlAPtaD16f7os21XtBkVEuVZF47slWHbWbniFiQmvYNkWlcK76HBlBpmphY
         eMOJ9B4HJJw0QuUSK05nGeIfVdi4S+pbrJbiVpkZlXf7RZ88/q0gLDl+5tUOBRhlSPjd
         6yJKCCiSOff3Yu9Uo6B6BvxnXhJYa3TqH7qnKIqQS0wp4HrBqHeGp2rxIsWOyS+vVcqr
         wF1J6fUwpVcdTtxopQsK4YVf+85TdJ/bvMUaOpiYcMfNITzMSMNU8PoH9biRXrJqwZ8r
         7UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702789197; x=1703393997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+UltNrsyGWSVcT46lR5ejKknw3QMITEfIA00sFphM4=;
        b=uYZbUViZKD3FFQYYZE1CRw8cWDR0n3kOoDndYjD23Yov7BwWiI2LIoXLQJ435syNUq
         zI79Q43QzB6o9wVAuamBSvxQAxqB879g79KgRuJnIIw+A1K5Ou3U/sz3Z8Xn6EsAh5Bc
         /vO/ZEjSiICvi2qJzikAFRbZhsnjz6pvLUSwuyqIQ0F13ZLqdUs+X4/7f/0EkMFkzylP
         0aF7sXePT5kz79YgEUFnOX6GazfKDKZlL5Ylf+eNDE739gu+MQBty7xvPifEiFnXy4uE
         k4OzOC+kea2EAYzTCbuAA1v5q53Ue97ASO1NCx+zu+bDca0VMeZelypehSpskRXTCtKb
         /l4w==
X-Gm-Message-State: AOJu0Yzuium0iBSr0/+nJD5h+T6HesBN7Mw3cq4JNv2ZG3Viuvqq4rhk
	ntMT/Ne6ypszwExn93ltpISwvLhcq+3OsQ==
X-Google-Smtp-Source: AGHT+IFKJJbsIK9fuyNGgNZuSaHKM+ohjM8BhwnIAryW0TJHEnQCLhkedKn1UdldO2ou4tQIup8nsw==
X-Received: by 2002:a05:620a:4591:b0:77e:fba3:58e2 with SMTP id bp17-20020a05620a459100b0077efba358e2mr18292087qkb.115.1702789197601;
        Sat, 16 Dec 2023 20:59:57 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id m1-20020ae9e701000000b007759a81d88esm7217485qka.50.2023.12.16.20.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 20:59:57 -0800 (PST)
Date: Sat, 16 Dec 2023 23:59:46 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
Message-ID: <ZX6AQg1vz/Zz6JeG@abdel>
References: <149032e99136a9fe47c3533b57a71092646e497d.1702744180.git.alkuor@gmail.com>
 <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>
 <aa93010a-7ab0-4b9d-bb5d-25ea15b81120@roeck-us.net>
 <ZX4frjGqOGb4zMmx@abdel>
 <c606c40b-8571-4618-827a-555ceab3ae74@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c606c40b-8571-4618-827a-555ceab3ae74@roeck-us.net>

On Sat, Dec 16, 2023 at 05:40:35PM -0800, Guenter Roeck wrote:
> On 12/16/23 14:07, Abdel Alkuor wrote:
> > On Sat, Dec 16, 2023 at 10:46:53AM -0800, Guenter Roeck wrote:
> > > On 12/16/23 08:39, Abdel Alkuor wrote:
> > Should I use tmp112 params for as6200?
> > 
> 
> Sure, or just add a separate entry for as6200.
>
I think some modifications need to be done regarding setting the default
configuration for chips with config reg of 16 bits.

Currently, tmp112 set_mask and clr_mask look like this

   [tmp112] = {
   	 .set_mask = 3 << 5,	/* 8 samples / second */
   	 .clr_mask = 1 << 7,	/* no one-shot mode*/
   	 ...
   }

and in probe function, we are using i2c_smbus_read_byte_data which
basically reads byte 1 of tmp112 config reg and in lm75_write_config
it writes byte 1 of tmp112 config reg. Now based on tmp112 set_mask,
we want to set the sample rate but we actually setting R0 and R1 instead.
According to tmp112 datasheet on pg. 16, byte 1 is written first then
byte 2, where byte 2 has the conversion rate at bit 6 and 7 (CR0/CR1).

tmp112 datasheet: https://www.ti.com/lit/ds/symlink/tmp112.pdf?ts=1702713491401&ref_url=https%253A%252F%252Fwww.google.com%252F

Now, to accommodate 16 bit config register read/write, something along these lines can
be done:
- In struct lm75_params,
  - change set_mask and clr_mask from u8 to u16 
  - Add config reg two bytes size flag
- Use the proper function to read the config reg based on config reg size i.e
  For one byte config reg, use i2c_smbus_read_byte_data, and for 2 bytes
  config reg, use regmap_read.

  static int lm75_probe(struct i2c_client *client)
  {
   	...
	if (data->params->config_reg_16bits)
  		status = regmap_read(client, LM75_REG_CONF, &regval);
		if (status < 0) {
			dev_dbg(dev, "Can't read config? %d\n", status);
			return status;
		}
		data->orig_conf = regval;
		data->current_conf = regval;
	} else {
  		status = i2c_smbus_read_byte_data(client, LM75_REG_CONF);
		if (status < 0) {
			dev_dbg(dev, "Can't read config? %d\n", status);
			return status;
		}
		data->orig_conf = status;
		data->current_conf = status;
	}
	...
   }

   static int lm75_write_config(struct lm75_data *data, u16 set_mask,
   			     u16 clr_mask)
   {
     
     if (data->params->config_reg_16bits)
     	clr_mask |= LM75_SHUTDOWN << 8;
     else
     	clr_mask |= LM75_SHUTDOWN;
     ... 
     	if (data->params->config_reg_16bits)
     		err = regmap_write(data->regmap, LM75_REG_CONF, value);
     	else
     		err = i2c_smbus_write_byte_data(data->client,
     			       			LM75_REG_CONF,
     						value);
     ...
   }

Based on that, the new tmp112 set_mask and clr_mask would look like this instead,
  [tmp112] = {
  	.set_mask = 3 << 6,	/* 8 samples / second */
  	.clr_mask = 1 << 15,	/* no one-shot mode*/
	.config_reg_16bits = 1,
  	...
  }

Thanks,
Abdel

