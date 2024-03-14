Return-Path: <linux-kernel+bounces-103250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280C87BCF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836701F21D20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430C58AA9;
	Thu, 14 Mar 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVPGyPfW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7D50A87
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420368; cv=none; b=YE2lw1hBz01j3Ui0osHwYyAePFSbS6PGTzUZ0531on5+Br6UUZ8JKvfuxIqV7wt4fsUY6l/eTkIDCe/I7TNxKen1sAOn+IjpFgywqkW/pBQSTxNBMYEyKI1n1gG8sPaWMCNQs6pwhMbN6E0k/8724FV6Gva0ALRemZr7UOe4+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420368; c=relaxed/simple;
	bh=2u/MtyPUOuwJV9gWG4DIkvMCxw0gFRHn9F3Oqc19+1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IfaqEtiHpfPvEiQ0e4kINGJnf0Sr2ns+4BNyiP4Z35idlMHi/qJg/l8/0T4RYNXEuXs84SQ6YMRz4I+WiMhbcCp/xAI5ni8rOqz4TFC5rT1C2unB3O1zmiddYSIW0p4WNlSIJ8SmgrSt1XxdtLejjB3AQ+vL5hKGcmQ+20ddV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVPGyPfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710420366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2u/MtyPUOuwJV9gWG4DIkvMCxw0gFRHn9F3Oqc19+1g=;
	b=bVPGyPfWk27C+MQ8L7qae0IN3JUhWzzxBqlJgAjnxLqvNOm2SuckbvfGNFjR3zENxmQVbX
	Ve/MaTMI630rPpZxlyXG3JyHY0Q5RVLINa8F+MAkl6jnhbW+CFfU1/Rv012wpOWmVWEgPG
	WNaIpyt2x66NZQpJoMxXVEQ8W9xFx+M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-zxL4fu6FOlm8GzY18bVsNA-1; Thu, 14 Mar 2024 08:46:04 -0400
X-MC-Unique: zxL4fu6FOlm8GzY18bVsNA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e9dda181cso222973f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710420363; x=1711025163;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2u/MtyPUOuwJV9gWG4DIkvMCxw0gFRHn9F3Oqc19+1g=;
        b=qGCit6XoVB9zIfhxiMbvyi1V2HoIqXlqiXNYQiuDKpwxHvtgG6TH24W/lWqXp20Oyx
         kYcxPhhWszcxX4mY+9i5BgrgNup3vgIUN53b6ZSOVrceenznA2xg8dlJ/jgUIA4pcWbG
         c+yF91brVyjlGZq0upk2XCH0bM9N08ZU3U0MUh8YdJIm9LQTLioR75hYGgpJR8vMYY2e
         StsAyR/NmTamveBHjPVDfW8evouA1+e5JXO7/xETGGDgJ8SjDYdixwBCSS9P2Nfp5WTN
         zbsRI21bmFVf5BYYC4TmZ4gqizl5Ai9lHgF7gVHPGmSg54a/PWCoYKJCuRr/75H25nbE
         ImWg==
X-Forwarded-Encrypted: i=1; AJvYcCURQqLZeP+7ogvGk/bMbzGeNDxeuwSYqPgjgBD5zDvKPZdUxlYQyYfj+klXdxsZj1BLYXcd0TBleRSk1N60IbJNhPOB3vdvmcxpToKz
X-Gm-Message-State: AOJu0Yy3bPYAM7Lt8mCpqcYmCWbNl/Fvxe7EmkAo56XleTVyzj2m3yKw
	U4Klv9QcUdPZk46m/JddBtw9wJW0po74CfkSBHW1p+RxBBj0X8Sou4WaFMhchpAmkF8PcKlnDFW
	tUDz8AaIZdH4+AGhrexmeyuQGIgaw9uv55frbx9TdPqeJEZcojhSIOYUlpfL2EQ==
X-Received: by 2002:adf:a34d:0:b0:33e:1f2e:bdde with SMTP id d13-20020adfa34d000000b0033e1f2ebddemr1109724wrb.3.1710420363506;
        Thu, 14 Mar 2024 05:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgL1cdkWxEpa3yx6JeKY0EXVo9XQOQzRnWJGB/Vf6kZuP5ocz59FK0YRgB3P1+C1ahsYQWtA==
X-Received: by 2002:adf:a34d:0:b0:33e:1f2e:bdde with SMTP id d13-20020adfa34d000000b0033e1f2ebddemr1109701wrb.3.1710420363143;
        Thu, 14 Mar 2024 05:46:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-217.dyn.eolo.it. [146.241.230.217])
        by smtp.gmail.com with ESMTPSA id v18-20020adfe4d2000000b0033ec9936909sm687559wrm.39.2024.03.14.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:46:02 -0700 (PDT)
Message-ID: <24a7051fdcd1f156c3704bca39e4b3c41dfc7c4b.camel@redhat.com>
Subject: Re: [PATCH] net: txgbe: fix clk_name exceed MAX_DEV_ID limits
From: Paolo Abeni <pabeni@redhat.com>
To: kuba@kernel.org, Ido Schimmel <idosch@nvidia.com>
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>, netdev@vger.kernel.org, 
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com, 
	maciej.fijalkowski@intel.com, andrew@lunn.ch, wangxiongfeng2@huawei.com, 
	linux-kernel@vger.kernel.org
Date: Thu, 14 Mar 2024 13:46:01 +0100
In-Reply-To: <20240313080634.459523-1-duanqiangwen@net-swift.com>
References: <20240313080634.459523-1-duanqiangwen@net-swift.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-13 at 16:06 +0800, Duanqiang Wen wrote:
> txgbe register clk which name is i2c_designware.pci_dev_id(),
> clk_name will be stored in clk_lookup_alloc. If PCIe bus number
> is larger than 0x39, clk_name size will be larger than 20 bytes.
> It exceeds clk_lookup_alloc MAX_DEV_ID limits. So the driver
> shortened clk_name.
>=20
> Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>

Unrelated to this patch, but more related to the self-test burst this
patch landed into: it looks like that since roughly the net-next PR was
merged back forwarding debug variant of the vxlan-bridge-1q-ipv6-sh and
vxlan-bridge-1d-port-8472-ipv6-sh tests become less stable.

IDK if that was due to some glitch in the AWS hosts or what else. Just
an head-up.

Cheers,

Paolo


