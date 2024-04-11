Return-Path: <linux-kernel+bounces-140400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400A8A13EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754EC1C2159B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C914C5A1;
	Thu, 11 Apr 2024 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKYDMK3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338B14AD24;
	Thu, 11 Apr 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837031; cv=none; b=Obn44fUOG9OF+qvjUGw0/tOBwQwUAWe3VLbajGRdB9uhO48ZKzz2UoTZbVjgPo8IAxFy7BmAsSZQPRmyUsPkjkyePAMU/FKnwQaoKy2ea9K+8Da1zD4PX+s03iC2/FswBvWe+zuqrh+cKn5Smx3E1da7JNxHzX2FIRk9JHS/fSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837031; c=relaxed/simple;
	bh=oltkbgJz/lUcQWtwkLke/qM0DU1bwDW6wogBIn+i780=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4ErHE+8SmxFR+BLCVRkiNvz3Cvn4Fq/C1iWw4oN298WiPIDbjzaTT1PRjceFOQ4lNlr+ORdHqKdLvmTzO2eVW5kTOqZQlMO8UbDLXZZ6GFkko3yZWOXe6+U2hdpsgBZrfIyKNRPuQ7HEVSIAYVK7l+oJj/vc1OutCfpEwjpCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKYDMK3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B608C433C7;
	Thu, 11 Apr 2024 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712837030;
	bh=oltkbgJz/lUcQWtwkLke/qM0DU1bwDW6wogBIn+i780=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKYDMK3iUyUAOAqGAdXCtZqI4PHO1hUEa+vVgCaVnZbP7/HZax/WvuruCdVXLpiZ+
	 fITLONyNAJrOiKejW9o5JiBe6r4Usq9A7jldYoqRvOgU2Gker3Xf+qBKZhsG5F6NFY
	 ZDQkPjOsDABS8Kmf+z23LoZuYVWxnhMHXfdm2XqM=
Date: Thu, 11 Apr 2024 14:03:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 6/8] greybus: Add mikroBUS manifest types
Message-ID: <2024041103-nimbly-pounce-aa36@gregkh>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-7-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184908.500352-7-ayushdevel1325@gmail.com>

On Sat, Mar 16, 2024 at 12:19:04AM +0530, Ayush Singh wrote:
> Add data structures for parsing mikroBUS manifests, which are based on
> greybus manifest.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  include/linux/greybus/greybus_manifest.h | 49 ++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
> index bef9eb2093e9..83241e19d9b3 100644
> --- a/include/linux/greybus/greybus_manifest.h
> +++ b/include/linux/greybus/greybus_manifest.h
> @@ -23,6 +23,9 @@ enum greybus_descriptor_type {
>  	GREYBUS_TYPE_STRING		= 0x02,
>  	GREYBUS_TYPE_BUNDLE		= 0x03,
>  	GREYBUS_TYPE_CPORT		= 0x04,
> +	GREYBUS_TYPE_MIKROBUS		= 0x05,
> +	GREYBUS_TYPE_PROPERTY		= 0x06,
> +	GREYBUS_TYPE_DEVICE		= 0x07,

These need approval in the spec before we can add them here.

And you are adding 3 different things here, not just one.  Shouldn't
this be 3 patches?


>  };
>  
>  enum greybus_protocol {
> @@ -151,6 +154,49 @@ struct greybus_descriptor_cport {
>  	__u8	protocol_id;	/* enum greybus_protocol */
>  } __packed;
>  
> +/*
> + * A mikrobus descriptor is used to describe the details
> + * about the bus ocnfiguration for the add-on board
> + * connected to the mikrobus port.
> + */
> +struct greybus_descriptor_mikrobus {
> +	__u8 pin_state[12];
> +} __packed;
> +
> +/*
> + * A property descriptor is used to pass named properties
> + * to device drivers through the unified device properties
> + * interface under linux/property.h
> + */
> +struct greybus_descriptor_property {
> +	__u8 length;
> +	__u8 id;
> +	__u8 propname_stringid;
> +	__u8 type;
> +	__u8 value[];

Don't we have a "counted-by" marking that we can use to show how big
value[] here is?

> +} __packed;
> +
> +/*
> + * A device descriptor is used to describe the
> + * details required by a add-on board device
> + * driver.
> + */
> +struct greybus_descriptor_device {
> +	__u8 id;
> +	__u8 driver_stringid;
> +	__u8 protocol;
> +	__u8 reg;
> +	__le32 max_speed_hz;
> +	__u8 irq;
> +	__u8 irq_type;
> +	__u8 mode;
> +	__u8 prop_link;
> +	__u8 gpio_link;
> +	__u8 reg_link;
> +	__u8 clock_link;
> +	__u8 pad[1];

Why the padding?

And this looks like a greybus thing, not a mikrobus thing, right?  Some
description of exactly what this is and what it does would be good.

thanks,

greg k-h

