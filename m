Return-Path: <linux-kernel+bounces-154965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD088AE3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC271C21919
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1447E792;
	Tue, 23 Apr 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duhpoVgC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3167E118
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871149; cv=none; b=LL9t3Pvmc/DmHAbdygi9G5UO2ojzhq0Qyz3qyPhTWe5YdOB1/xFxCv2rBZDUBUGlyv6lzq/QbenKEIMNS+pH+XBQi3pxa36dyTS41wYD8FPVpQ7pGHiCbXpkntxKl8bUugrvtNB2H3Gi52DgYugRR4SYtI6lKoZxV8nnHtk5g5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871149; c=relaxed/simple;
	bh=KZP9VCw1/Uo3VBFKKbE8e0yd9jVZbtVuTAHNJpHQ5Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7opetCLulp+8j7Iap6o9kHnp1vr+SCILOzQXS0Sw2zWMdL1Z9iPFoCbBO1oV1tcXRqDIpCO3JbBEyO1ZZuwY5zuzGyGZMqIwRG8Xpn5ua9atPZ0dPf2HD8yDumC+VNYyMQL6ktgXrii14nWqAQzrInuJvR2+zoi/C/pvVQ2IfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duhpoVgC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713871147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZP9VCw1/Uo3VBFKKbE8e0yd9jVZbtVuTAHNJpHQ5Jc=;
	b=duhpoVgCtts4E9YEYIoV6ZsXtkdLUA4vTroovIVHKO319v5Ntu45ARvgqRU31FTB7NgqrS
	UYu88qX4s+DOQ6t71zeduvVb/yIirST8NjdGgH9bLVmE2lRaT586nwEikJbMKQfJeM44bG
	dEqJDuodWIZt4PtTKJXS/Pb2o580vmY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-KaDJTMf6MvqnyU2AF1MWsw-1; Tue, 23 Apr 2024 07:19:05 -0400
X-MC-Unique: KaDJTMf6MvqnyU2AF1MWsw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a58765c5770so59400866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871144; x=1714475944;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZP9VCw1/Uo3VBFKKbE8e0yd9jVZbtVuTAHNJpHQ5Jc=;
        b=LOfHvt2UcZIQNpe36srPXkdkFkUstQf26MHy9oH4HzCdxCS8MKJmRWXSVNDHoblCS1
         aGIMEg7+Gj+zURhS8suqfxX7qJ4vtxZI4T0+lreyDrMdFl76dOQHpij4+Bkzroq9qyPx
         WoJOYEicfiDOyQvZnroLDYcHFlnu6Li8wrJwohQoAA3tC2aumYG+Z4aMrLvaIZZEHNon
         olkNcHraUVfkpqpLCdWJJqZkOi/j/zxrOY/IZoud8Ac1GxknlQlpZ9u3gs1MCBZsJ82/
         wvmDZke64F8cf/RTYPQhnp1hnNClvzJg2BWJkxdivTcKEF1qhief17FIAVbC6wYA2Ahj
         9Zpg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ45dtGtyL5gnqalrYJQ4+viSGUV3HW+44d3Rx48l8mVZMJY3pkclNyVflET8HESv3+NEkF1hWWKWZ+uoSsy7olTahuL4IJBgMiHhf
X-Gm-Message-State: AOJu0YyyKfeB7lBr4LbqZlBhhi+UNqKyIyzu35kOwzejL3ynwwP8ksGd
	C5KrRGeEop0yfTMxrHnPSveuKrfLtRxVBErcGUtFwCJLDyyXR1AzzN/iAx+fqLyz2HetjLvrjpg
	bnbfhxk9qKeCNfOUy92SbX0VytEBxlNruSo08662onrlEmwexIQkivsPqNhoLXMfliKrYXQ==
X-Received: by 2002:a17:906:3b59:b0:a56:4c83:fcb9 with SMTP id h25-20020a1709063b5900b00a564c83fcb9mr3406817ejf.55.1713871143832;
        Tue, 23 Apr 2024 04:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaCMQYjFIyeyYbxA/+uCn7lL6cZiX8H3MkJhY2sRHk6IUsyj3HEaxdCPeuK8Ec7M09N3WXDw==
X-Received: by 2002:a17:906:3b59:b0:a56:4c83:fcb9 with SMTP id h25-20020a1709063b5900b00a564c83fcb9mr3406799ejf.55.1713871143460;
        Tue, 23 Apr 2024 04:19:03 -0700 (PDT)
Received: from [169.254.21.156] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm6912925ejb.8.2024.04.23.04.19.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:19:02 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Jun Gu <jun.gu@easystack.cn>
Cc: pshelar@ovn.org, dev@openvswitch.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: Release reference to
 netdev
Date: Tue, 23 Apr 2024 13:19:01 +0200
X-Mailer: MailMate (1.14r6029)
Message-ID: <77015793-E8E4-4AD0-A032-9E0A7F7F0865@redhat.com>
In-Reply-To: <20240423073751.52706-1-jun.gu@easystack.cn>
References: <20240423073751.52706-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 23 Apr 2024, at 9:37, Jun Gu wrote:

> dev_get_by_name will provide a reference on the netdev. So ensure that
> the reference of netdev is released after completed.
>
> Fixes: 2540088b836f ("net: openvswitch: Check vport netdev name")
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>

Thanks Jun for the follow-up! The change looks good to me!

Acked-by: Eelco Chaudron <echaudro@redhat.com>


