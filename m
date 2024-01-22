Return-Path: <linux-kernel+bounces-32306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A38359D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4823E28368E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAF5226;
	Mon, 22 Jan 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEQa4ZDd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507004C92
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705894854; cv=none; b=BNRXVPQxqDG478AbEDf1TiNvvJm7IEsuwSGM34CfrsEHVAskn8Ltw7vSXtugO4KtMZ60DzPq81PpxAxzB9aE2Ey2cKk/mrAEnFil46qBg+H/dl43VBgTR+/+KAk7fiuoccfGCvew4mF1pieD25Yh7b0kYvZM1OdNwBeor3cklmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705894854; c=relaxed/simple;
	bh=NFDO/S9sTGJ9PBw0tPvhlSJST2+RhpttNVynn9R146U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/0hJNwrvzVxadDst30hjwF5pJNbrlrKNAa7/b7tJgws9JhCg7FdRj0Mt+obJT50Lnz33OhWbHwxm2Wgp0IZyGDPgRhuwxgxLGJrzaL8ASYdeS1loxu6aHyBm7IDiIEVgCdhOAQBSlyvoyktKdwoSkhQygW1zfPHuWDYY4HFC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEQa4ZDd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705894852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFDO/S9sTGJ9PBw0tPvhlSJST2+RhpttNVynn9R146U=;
	b=OEQa4ZDdchAt5hRZmyuWVowb+Z7eGdrFeWYNQdrlZbqx/5gHPIbnOSVg66WRnezsW7yX7z
	/vCYA9dDvqopyheS0qkmYCoXomTddw+wpSpgvPUZ7/yzmeVbYMuRYp10vrS7UkS4KoZWU6
	IUjNDFiSNKY/pXbm+z6xaRARlNDNI58=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-eS8Elj3yN_Gx6n0dqYiOxQ-1; Sun, 21 Jan 2024 22:40:50 -0500
X-MC-Unique: eS8Elj3yN_Gx6n0dqYiOxQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-598e30e7e8cso2644194eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705894849; x=1706499649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFDO/S9sTGJ9PBw0tPvhlSJST2+RhpttNVynn9R146U=;
        b=l5Wu4dMvwvFUsuTDDdlzPzwUl+52BY1CJDblkCMmj5RHFb0J+z8nSAvh1yOi73rhxw
         DG8nrOTiWQs+ho+KmXQVGjeZpwPMwjAq4N0H/EDvIpvP345Wqp/XDaDHfbooDTMqaqJf
         gI4AmFFj13jBBCKcKZBQkd+6zWSDm5ZLWhCuQPpsYD1ourrJY1gcZUj+tu81YuqvWdWw
         HZbazD5uzODKf7ArUVKQ7urSrwGYd5RsAq8R4qyadXQEJy4hlWwkbw2f49kBPZSIgxmL
         pMYZ2aXFyfR9c7/CKjMf6xmX0xLwBNoZbmxPMf3X+cL/GS/30BzfogXi3H5Rlk82Idvv
         w2kg==
X-Gm-Message-State: AOJu0Yyg8vbttpsDMotVO4L02XQpohHcxcpceB15oyja8DsTK/SVNihN
	PO0EiOzmv5/WNEMcoTaplw0yovG+/AbDWOUtKuB1rqW+GdysOFpAiRTMM02cwgYAMSCZvnZiFZc
	Og+pzNOS+DuujZjmW6JX+KtgdJ3LxKxGFPtBfcorSz3K3Cgs5owzKdRwl1b6UL3oFr87Bz3yUoE
	ndHnYBQD/ynt3NWTgxJvpi9qhQQFpe0g4Zeh2i
X-Received: by 2002:a05:6358:917:b0:176:4ed4:bc64 with SMTP id r23-20020a056358091700b001764ed4bc64mr305864rwi.26.1705894849093;
        Sun, 21 Jan 2024 19:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp2MTnFuCfcO0cpNTXwF8TVpOM8IaPRjH8DJYvhD+oni+Ctps91jRas926NgOAcRQv3rouXXOmASXeW8A6y+g=
X-Received: by 2002:a05:6358:917:b0:176:4ed4:bc64 with SMTP id
 r23-20020a056358091700b001764ed4bc64mr305854rwi.26.1705894848831; Sun, 21 Jan
 2024 19:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705659776-21108-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1705659776-21108-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 11:40:37 +0800
Message-ID: <CACGkMEu6VtxxoRxfjMijpgC=qZmbsrLiJT8=0dgGzjqnz0CReA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tun: add missing rx stats accounting in tun_xdp_act
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:23=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.co=
m> wrote:
>
> The TUN can be used as vhost-net backend, and it is necessary to
> count the packets transmitted from TUN to vhost-net/virtio-net.
> However, there are some places in the receive path that were not
> taken into account when using XDP. It would be beneficial to also
> include new accounting for successfully received bytes using
> dev_sw_netstats_rx_add.
>
> Fixes: 761876c857cb ("tap: XDP support")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


