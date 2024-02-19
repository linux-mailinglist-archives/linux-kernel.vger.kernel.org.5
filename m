Return-Path: <linux-kernel+bounces-70709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0B859B66
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD84E1C21B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C7C8FD;
	Mon, 19 Feb 2024 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7OReeQR"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB863B3;
	Mon, 19 Feb 2024 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316794; cv=none; b=CvlIRJH872HZIe0z/troDzzsmMxkS8Y4AWGvXb1GtEXAPOhOAohFB2ayvKMahcspG2M224eYLxvGn0xJ8qnbcYZSXxWjQ7JXga3lBMcsZjTnnvGty91iJIVSzRggWodYFcwPbdf1sGAyWuKl67HPaScR02mt1aF+HvwP3FdIgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316794; c=relaxed/simple;
	bh=n9cVINVVeUQ7a6yT1OPSYHFXjTFZteQyoAsMJpuvlM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jotE2OxC3yH97zvCh3sHqfNUfxxfy1mII93BnD6DapCpUldQB2/KUEm1D22EbNdbV6ubib1CDBFOVctygZkuJAc8b9jgGHInyq1KKTRoRV8YNSPvhKSr2Tr+RwO9lGGjp6vENb46O3SWCwjlr/anmCbpeQWByisvuQpG0RvbFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7OReeQR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1404d05bfso2501589b6e.3;
        Sun, 18 Feb 2024 20:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708316792; x=1708921592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8jLBR+wUVXC8fLxBsadkCVVQvYdLsp9BAEZYoHcJYU=;
        b=H7OReeQRzUHsLM0NEgv430iVBEIdMB+SODdpjD4eNDpJAT/SfeOZEc2hSFwOIJOr1s
         ZM2mcJGVdWPI1BP6sIAcl/pRZTLjUOeRwfycgd3CzgAj60FeyBQHLhXEY+i92GfYOooe
         51tDZJeLY+IxcLFvRzG1QsNrxndeLdaOclsdf2oaubrouaMskxmil6Kei1pLplwcXzq2
         8VxrPt+ipr8dQEgeEmTSPABX000nsCihxIfx1oww9MktHbYm6XVKB9xdK4jkWPsRM1O7
         RvA3Ee97UkXJLpnhtyWG6FCczX1sIllXF8ifEwt+4jN92zif4779R+/YQVB0sDzwMGyc
         7AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708316792; x=1708921592;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8jLBR+wUVXC8fLxBsadkCVVQvYdLsp9BAEZYoHcJYU=;
        b=vi7qkaa7QZ4O+lIlJKR+jINXxt6jMntJHLW5phJqVgdKn1CUzCEc3ULN/DZ3VwTa/J
         Dg3gu/FVWY81hs4hRn81+G9AIfm03ZX83RJLNuCeYHu+W0CZDkBWvCK6E1mZIzV7AcmB
         JFBwl+z/PRIzHU0wHyjwAEfsLOrH5yYXjrItVFvM5MwN6P0TnKQQGnN6JrKZ0mYHKd4L
         DUgPmrY5eemxiNAC6ybN+CKX0GzkLZ8LHa0hI6ewLzRrRejedScAoM2hCO/PDMAQvoL5
         TTpPnZT1Xb/HexnXYy3+GMuAPnHlwb4XgZICgmz60pRMh0G0ylbPxTVXAtyl4ocdpLTB
         9y2g==
X-Forwarded-Encrypted: i=1; AJvYcCV1qm8+Q/lh36ywx+yEXMNoLhTglIH24rx47XMLK6fzs1d1BpjS9c246mk4qR3mUYbfHkEbAW+6EPfjH4b1HuT3SEQVkzOpOM9U3nfmn1yARFnDXa3Hxt5lFQcGv/gvVpGXExvF
X-Gm-Message-State: AOJu0YzLyoSeNbcv+1Owo1rOusNz3K1pcBC/sYbSoM8OEsBwrQxVZ3Oq
	grLdFOQMYjuL/T7eKinAWOKyjRwmkpWQnJuvDjPH+EFeoblk9bsE
X-Google-Smtp-Source: AGHT+IHVqMRlOqIH4wgN0nkqEjo+7JQ69GvJzGhVRk3pRqPrLLuJuwnwpt/ksbnvzS/243FF8tU8MQ==
X-Received: by 2002:a05:6808:17a3:b0:3c1:37d9:dc93 with SMTP id bg35-20020a05680817a300b003c137d9dc93mr13745293oib.10.1708316792302;
        Sun, 18 Feb 2024 20:26:32 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:e814:598f:2d92:8806? ([2600:8802:b00:ba1:e814:598f:2d92:8806])
        by smtp.gmail.com with ESMTPSA id s27-20020a056a00179b00b006e3cdae7e60sm2280327pfg.58.2024.02.18.20.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 20:26:31 -0800 (PST)
Message-ID: <6146eb3b-720a-4523-bcc7-8e2656aeafef@gmail.com>
Date: Sun, 18 Feb 2024 20:26:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC PATCH 6/6] net: phy: bcm7xxx: rework phy_driver
 table to new multiple PHY ID format
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Robert Marko <robimarko@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Puneet Gupta <puneet.gupta@amd.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-7-ansuelsmth@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240218190034.15447-7-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/18/2024 11:00 AM, Christian Marangi wrote:
> Rework bcm7xxx PHY driver table to new multiple PHY format
> implementation to reduce code duplication and final size of the compiled
> module.

I like the idea of sharing as much code as possible and creating a 
smaller module, however by changing the name, you are creating an 
user-space ABI change, we rely upon the exact PHY name being shown under 
/sys/class/mdio_bus/*/* and this change will break that.

Thanks!
-- 
Florian

