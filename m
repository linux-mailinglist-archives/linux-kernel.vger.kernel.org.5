Return-Path: <linux-kernel+bounces-32305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200238359CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B86B283209
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95066184D;
	Mon, 22 Jan 2024 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgnVhY6d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DF17F8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894837; cv=none; b=Y/JIIhcE0kQ6e0eTT75Z76kqoyOdz6RJ96GrERqK8g+BwOShRMpTq479S4m+ZDHDGW7qcLlqr849svpxDpW2qwFZUHkqehhGQ40EJZXAHJUUyhIn26Nee+SK9Vxqndq9eSutO5N2zQuIEucBKHfuCUjcEP3i0TYBQT/AFzTiV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894837; c=relaxed/simple;
	bh=S5KdSBGo/OQbzXmjf/Oy55uC4cHDaOjB+p3jTQZ1gGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YukE3kPlqhCp43J2z3Xr+CKwBZbdrmj3l1thEjnsHqkMfaKJt3FRWCfbA5XeCc5lt4rQLds+GoyVn4eEOEfrti3L1NLRK/OopP6n+0ur94L9QiMoCKN4T5+WvkB1t4rOr0NdlNY/NIzY+snypNwnvLuIXCYyIXKgQzfzPoyAVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgnVhY6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705894835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5KdSBGo/OQbzXmjf/Oy55uC4cHDaOjB+p3jTQZ1gGA=;
	b=RgnVhY6dHWB9jANk6aj0dwbmpSdMNYWK9Wua9lSKFiTXskILcBzkQcL9/a3DxVuoKTtlqH
	WSOktLQl6Al8YMGeHUG9+cn4OXrbVx58EXNsJKQLT4/QX2sKAg/NgqE1nOYX/1+zExMCZ+
	5ufJqeM6VDPUp+omfhEANIziqF692wM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-pTgLdHi8NjiA4L6AYSP2DQ-1; Sun, 21 Jan 2024 22:40:33 -0500
X-MC-Unique: pTgLdHi8NjiA4L6AYSP2DQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5993598d215so2432368eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705894832; x=1706499632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5KdSBGo/OQbzXmjf/Oy55uC4cHDaOjB+p3jTQZ1gGA=;
        b=w+SZFy8Pm6jaJT/hR0WaP6jAWjRXH/8cOVXkKk9SzqiAe8qgjrzftNO9IdLeKwzEMd
         MjIFcBEsAzDFobR/X7xaxkShyY25Ic+W0IjDt4L9aPy/ayOrw8EOArAwnOx3SK1lK6uG
         6/mR7fi3YVSvYQM66wQNYBury9BvzYyBE5Hvqrb8xdQcEzSjL5QG9J/pRAeieSqSNJOq
         4yrsustPdZbuArk8n8MYYeatR+GqNVSGkL/S2VjEpoRK6iXmVj7Enri4PHBDykVVCNqO
         svq23SlgG79BJLQgSblI08xf1PkZVVeDl2dWV+SpfQdnglzmrPhJzbDyQqYrO6oRqJkv
         D1og==
X-Gm-Message-State: AOJu0YyuKm+6KJaS37YbUg66pq42q2AkcgT5eltOA3agjCrsYlZDVN0X
	5jFJIWHu5yDPr3QeQc3eiMpJ6y0SUWY8RejOsirXYpVC9m6wd+JT+3IakRqJKBoq7Os4SHGE3Jc
	QpyhZabcm4YUHPETEqv9aikCh3P7sCwkMF7uARQMEhho4ZO3++eOcUHTT/mGRgRvlcHOH/PQDrm
	OnIKcW6xLJE+Vr4m7WsEz4cNuvt1w6QnJED2hH
X-Received: by 2002:a05:6358:6f97:b0:176:2c3d:fb35 with SMTP id s23-20020a0563586f9700b001762c3dfb35mr1884394rwn.20.1705894832475;
        Sun, 21 Jan 2024 19:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZwgJAgYtgwjCdGBZzqy4GvY5dlcCZYqs27qJEKxnCUiDP59Wuh5b80C7v3TyVv1+hCDI8N2QN6k3z+Lu18GI=
X-Received: by 2002:a05:6358:6f97:b0:176:2c3d:fb35 with SMTP id
 s23-20020a0563586f9700b001762c3dfb35mr1884382rwn.20.1705894831978; Sun, 21
 Jan 2024 19:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705659755-39828-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1705659755-39828-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 11:40:20 +0800
Message-ID: <CACGkMEuSGmH7ywQY9OeWE1FPdV6cgs15fqrddRtOsO8bW2nx+g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tun: fix missing dropped counter in tun_xdp_act
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:22=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.co=
m> wrote:
>
> The commit 8ae1aff0b331 ("tuntap: split out XDP logic") includes
> dropped counter for XDP_DROP, XDP_ABORTED, and invalid XDP actions.
> Unfortunately, that commit missed the dropped counter when error
> occurs during XDP_TX and XDP_REDIRECT actions. This patch fixes
> this issue.
>
> Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


