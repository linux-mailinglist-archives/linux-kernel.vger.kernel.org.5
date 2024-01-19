Return-Path: <linux-kernel+bounces-31446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AE832E71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A27DB24EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E45644E;
	Fri, 19 Jan 2024 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZHbEDlw"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D556447;
	Fri, 19 Jan 2024 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686878; cv=none; b=lAfPp96w2x0K6IDx73xZyxAky9BpOB+1LYwHczFFTVZIIASs/p08yavguRZEbkFN3z1BSb7hXNAK0ym6mnpJYMq0iPI+EVvwa1xGNYGmixCCztFsJpbau3vXkPICxi+blacc6gD2QGZ1Ri193kCZcLZJl6WGu1kvp2VIDXoNE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686878; c=relaxed/simple;
	bh=68EYDYNAlpBFekQo0be4DE8uzhKhInrTxSE5YEYYVeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uEK2t8F9QBTvLdh3MPyxFQMZebOCdJ0gUR8DlwYqxU4sVn5Uo+/t5nbx1Kr8IwgvlN1YKJoJTR10L8wggSkCRIKLbIxXws2w2oZ2q/pvx641C8rTWb544Zgae19BTjUsZzYFrOLWLVwmajoEdfkDRaMlneYmJ0Ex3GDLWu0vWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZHbEDlw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28e884638f1so1035104a91.3;
        Fri, 19 Jan 2024 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686877; x=1706291677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFh01rJlM5Qj4ibHe2SAP3HVSgqlTX84yBGnp8DV3CY=;
        b=UZHbEDlwmdV11MAr7VgtPyFzaVmHVi/5Tw+4UpvglSiLpYJarPepff3HOhpIBsG6fp
         ewXkIx1GSld/IKVjr0lj/u1Sq2/zk+hJz+Zwx/0pkB+W+wTW67GYyL7jh34rgH7OiEdn
         xtDiJIKKTNnrH+PTfaCZubpFUPSgP0kIz8Mq0W/jS/RNYVPrYy++iEBOYRaqPAlFF0eG
         eEKjXkh7GRKCFU1IqTWNHZiQFLSCoDuhqf825JaUz4E9IDGYaWvG60L+iNK/2Leq9kK2
         0MHB4exEk/yLBn/veqS2tS7qhNvf4TU7VWafO0eKWhcd5vVTEIfaPTCwkUPhOvfZw+11
         QO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686877; x=1706291677;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFh01rJlM5Qj4ibHe2SAP3HVSgqlTX84yBGnp8DV3CY=;
        b=r4Kh5F+TUDtey3jO5kXzx5Eitvhpa3qQD5USgXc3W/m0nhIUTQ3VLbcLbmSpUb9k9M
         aDClYRCO+x7DnGTH947XQdz8O6NBYfbEqy0oal1W/DRMtIny9P5naR88LhKImJodKwff
         nGHfJm9I+VSJSpfIV0pBnAgVOczYqDpHbDO31lxfPOL4bBmqWot2Pxl+SsYXc1D5TPMj
         FAbuYlIowRCoa/EvcOaaukvDSX/VTh7MB+Y+OVjPJ9UV1CF3eAbSxbvYOZ2c3GvG7P7V
         IC7RPa8xDsUWdsm3fpde8djOwWVFghABRg4lvkrCL+QGkJ+sx4G9CtuCQVeW2KEnRjW7
         NYYg==
X-Gm-Message-State: AOJu0Yz9y+TcQiEk0zmGMcTDg9eYLM3yQwxjKhO3Qo1QaOkYWjtoKt/q
	I77ZWNn3lToZEklZK1XYMDZWEoBZl6CpRJT4eC9GoX2TOS6aL3ay
X-Google-Smtp-Source: AGHT+IH8vPjf5QLsN1MA6I4v0K8HgrqbnCPZPYq3zzvwbj1H3Kdx7ANiKO7xz+ZfZQd97C3fP1Ac1g==
X-Received: by 2002:a17:90b:295:b0:290:2492:4420 with SMTP id az21-20020a17090b029500b0029024924420mr144066pjb.42.1705686876686;
        Fri, 19 Jan 2024 09:54:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id nb17-20020a17090b35d100b00290394b25d5sm2953663pjb.22.2024.01.19.09.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:54:36 -0800 (PST)
Message-ID: <7006dcc3-cc31-4653-a504-4e0deb46e131@gmail.com>
Date: Fri, 19 Jan 2024 09:54:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: sgi-ip30: Fix missing prototypes
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119133757.96563-1-tsbogend@alpha.franken.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240119133757.96563-1-tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 05:37, Thomas Bogendoerfer wrote:
> Include needed header files.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian


