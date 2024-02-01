Return-Path: <linux-kernel+bounces-47668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FC8450FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D490C1F29E22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2727D40F;
	Thu,  1 Feb 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiPDTYhp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6D7D414
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766568; cv=none; b=WbNLt+TGINeUzQA6o7H/2RTSqeEGJcJ7zCh4qqYXe7qK0n+ZlwAGQzVRHGR8x55qd0+1ABUfhY747619xQ/0fbBNMehk8gnFhTJyj8jbedZAiz91ZShXmaLSQWcGnD7DOONgG8i73h2511f9N/OLK2z0gN9pAUhr/yxL67ocrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766568; c=relaxed/simple;
	bh=KIExdWHVmutlvlT3+obd3h+YUc2wXhpfig1qUZ2NMOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRAqluRscF4BtG78IC0q/74unQsigDqT3JjCN6tmLbRn9w9BiwBQggCS4DFGttgcmiwg++YbIHIQGPTJvz2MELZ1eMhUAd+CzQI/pL7Z+mvcVf9z/QV3LHpUhnRvfEN5Tii1SNoomifzNnfqRlPMD26SQdINqxXtuhCc9YUrAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiPDTYhp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706766565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgbdx/AAaJZ7DeK9FOsHQhtQNYQ6A6a2HZZVAxKhKQQ=;
	b=HiPDTYhprKnOWm+9bzsnARnRuH4JvfeSrCVd4enMfyaQCzY2ajqJiYcJmrcG0cIVEBN63Y
	GT9jeJE0bjEuwQmRZI0RzzpBd1PjYwA3viS+uyMaSaX1aWMmaJwWWVVj9Hoxh4Wqo5SBSq
	fnL5Y/x7vMVkdQFIf+pMU6zbtvKjHTg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-E81zC3ISOUW0XSakED8T0A-1; Thu, 01 Feb 2024 00:49:24 -0500
X-MC-Unique: E81zC3ISOUW0XSakED8T0A-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd49f232c8so944605b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706766563; x=1707371363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgbdx/AAaJZ7DeK9FOsHQhtQNYQ6A6a2HZZVAxKhKQQ=;
        b=P099jl1CilnAoi91eelv5nqjdv9GqaLQLrDtCrP+lf5+gkDYB5p2BOtkhwFp0u1pZa
         OPaDofBTOFiFBTnSNmdi+9kAwx9zrGN/erujSTNVGa0cTXjxofhCV0O3ijYDNRlNgLb0
         XvQz7RbMptn8TJKhSSSOYqGjvKU+Ixd3tsDw69N5/oSAr2RAp4GZ2FGIDYcrYmhsO+0s
         eU0y5RxW/UlJ8iYwDRm8TD+p6ES/qvbyTZrpMfqHVilxHV+Vo1y2S7XjTBiDUtvipuuq
         1bptOcG7P4HPqtv/Lo7kBx6M3qnCvtGhWkEarPMGPDs/eF88x+c88FYYoCoPnByY9NK8
         8nsA==
X-Gm-Message-State: AOJu0YwfkcPRFeEM1NHkouN/O7f2iS9Nt3Yhb6b2t/2AnYedYJa+iz7P
	WkXTByHhVAD5Txbv2tpJz7GwpKWgQfoKyfhEYRzryYxsO+CIN462G33DaIKPFiBOW3/bZFwjhlJ
	IEHAetFFMn90LQPAfs5G+a8HmP6AX13vZLEKp6z4UwzTCliIzGY9wOZ0+QeZlBSrm8J1JkyZxD9
	yMNgVJbzzIgFiBXPh5xi74mjbwuSJ/xZInWsjb
X-Received: by 2002:a05:6808:3092:b0:3be:37ff:47d5 with SMTP id bl18-20020a056808309200b003be37ff47d5mr4229259oib.32.1706766563542;
        Wed, 31 Jan 2024 21:49:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXjMe0eEIqZ9DC5AR6JP7575RarbQIvdtQ/UTHdrVnUvzMt8FJ1hfqImdtib1VNlENwMqnPvjlqh4Qnql0aEg=
X-Received: by 2002:a05:6808:3092:b0:3be:37ff:47d5 with SMTP id
 bl18-20020a056808309200b003be37ff47d5mr4229249oib.32.1706766563285; Wed, 31
 Jan 2024 21:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130112740.882183-1-pizhenwei@bytedance.com>
In-Reply-To: <20240130112740.882183-1-pizhenwei@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:49:11 +0800
Message-ID: <CACGkMEsrMcAbrsfupDJ_fK_RTA8zRtGh77UBHeXZMiRxCaWypg@mail.gmail.com>
Subject: Re: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, mst@redhat.com, herbert@gondor.apana.org.au, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, nathan@kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:28=E2=80=AFPM zhenwei pi <pizhenwei@bytedance.com=
> wrote:
>
> sizeof(struct virtio_crypto_akcipher_session_para) is less than
> sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
> stack variable leads stack overflow. Clang reports this issue by
> commands:
> make -j CC=3Dclang-14 mrproper >/dev/null 2>&1
> make -j O=3D/tmp/crypto-build CC=3Dclang-14 allmodconfig >/dev/null 2>&1
> make -j O=3D/tmp/crypto-build W=3D1 CC=3Dclang-14 drivers/crypto/virtio/
>   virtio_crypto_akcipher_algs.o
>
> Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
> Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@ro=
eck-us.net/
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


