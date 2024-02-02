Return-Path: <linux-kernel+bounces-49702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBAD846E50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6964A28CFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225613BEA7;
	Fri,  2 Feb 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzY9K+ED"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD1F508
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871170; cv=none; b=oSXi/+Zibk8nfkxtR2gLGxFK5MZgsrZvzZIrwTq2zFCp2ozLETjI0X1FAvxe+1BAAfS5GUeNtMiC/uz7cX5GNZ+qy/+GMxif5dvLSJO0+9S2S7zRGp0d+nLV5+gbsWwJtZHJ5AnRr14YcqcB5qNduhPNeYnyeHWzHqcgiuXdmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871170; c=relaxed/simple;
	bh=/t5jbVDnTvAudor+E0CaRyF81HbhOTZ0aJFKGbE5sB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIH+vKXlTvZUPWZjHxYksZFDPuOLJzyD8kzrA4dv0m/uPttWwjheSnz05eSvzUADirhHMVM+3OwqQ5BmcWLOCMceg9gBln9GEgOVuM01ao/aZVov9Z4TBYSqF8Kz5icNjZHt0hAVe9hVl/ShHqvj8LelEXegP8UY9dFSf/0A9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzY9K+ED; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so2693893a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706871167; x=1707475967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t5jbVDnTvAudor+E0CaRyF81HbhOTZ0aJFKGbE5sB4=;
        b=CzY9K+EDJ0IJXsriaaQhxbV/PesKsr1z/Dp0L+MJhaDqRWQYj02mLG29B+ELzUr5Db
         TWP2NcWsEaZ5VvvMvWkKhcryko9VoHByTUgNTMR8SoXSwk2DNm1qvWlrwpU0/hoyHEe+
         eifO14pmyBkzq5Svw4R25W2NDpPPyfjkAbyh3Xol0UPq6R7MP+NCktL13qQbmY8bAqnn
         ALf5mh3Psr9zLjlYN/siTN0K6OM4Lt61kyTudgLuIrgCv09oAX9cCOrlYDAZqCSWogUh
         RMB7Xhf/0z7D0FfoZDbuFT5g2gEHBV13pdW3xgTPDfSRNL4LShe8RjvxzoDsbZstCmEw
         Wc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871167; x=1707475967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t5jbVDnTvAudor+E0CaRyF81HbhOTZ0aJFKGbE5sB4=;
        b=gJMqN8RzNyFyQq0KVLhCUjfB7+1stiCR48dvI8cwld5GBcz2j4M55ch4Bjd8blTvc9
         KA1LoEnb7+QXa+PjySgvDEUafMGvXJDvytNyCYO5kbrYsunwD8ybHu74Jywiw3Wg5xOJ
         QWmj+Emfzj/osZN0n8iJm1/MoL3ohQmXC4zI0eBhE5g7s4FeWiTH5EPxADMB/euN43KR
         1m8V3eZE9RXCzkaGERcywLG9D+VLpvsdh+o+abhr00/xG6jOfN/Yz2stYoLBp0k3G13Y
         hJOzSOlO3vfxBIGdJqHUr1Ak1mhoKrn9pkn1r0AfNndQeIucpAuo04cBTe9f+aqoFHCV
         CtFQ==
X-Gm-Message-State: AOJu0YyyYHgnUlub1x1iq5fW3jcKAAimvY2ah4/yRJNjdxTo1b5eplym
	XF28isSas4ZzewbOOoekhxXe2kxk3t2vWW5AhPuIid92nv72V03zVjXZuiuyncq0ac2VcnVKAzN
	/yN8LIVmSVEFFXl3r0uMagDKEtnXr2Jef
X-Google-Smtp-Source: AGHT+IHjMu+uM/BPol4nBaLioQgqb7a0TTS0b3hHo+5t7B1bjoet/E3OyH3hBnIahi0K8sQpB6yqllID4YXVtiDl7BQ=
X-Received: by 2002:a50:ab1b:0:b0:55f:4fab:8299 with SMTP id
 s27-20020a50ab1b000000b0055f4fab8299mr1372977edc.14.1706871166570; Fri, 02
 Feb 2024 02:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131035535.22258-1-liangchen.linux@gmail.com>
 <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
 <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com> <1706867854.8480594-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706867854.8480594-1-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 2 Feb 2024 18:52:34 +0800
Message-ID: <CAKhg4tJCGtPD0fyjmCfDTU3TUW6B8T9XRERT=Y6k3+D16QPeNw@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, hengqi@linux.alibaba.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Fri, 2 Feb 2024 17:25:02 +0800, Liang Chen <liangchen.linux@gmail.com>=
 wrote:
> > On Thu, Feb 1, 2024 at 1:37=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@=
gmail.com> wrote:
> > > >
> > > > The RSS hash report is a feature that's part of the virtio specific=
ation.
> > > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially =
vhost
> > > > (still a work in progress as per [1]) support this feature. While t=
he
> > > > capability to obtain the RSS hash has been enabled in the normal pa=
th,
> > > > it's currently missing in the XDP path. Therefore, we are introduci=
ng
> > > > XDP hints through kfuncs to allow XDP programs to access the RSS ha=
sh.
> > > >
> > > > 1.
> > > > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@d=
aynix.com/#r
> > > >
> > > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Thanks
> >
> > I've just realized that I forgot to include netdev@vger.kernel.org in
> > the cc list. Would it be advisable for me to resend the patch with
> > netdev@vger.kernel.org in the cc list to ensure it receives the
> > necessary attention for potential merging? Thanks!
>
> Did you use ./scripts/get_maintainer.pl?
>
> Please resend it.
>
> Thanks.
>

Sure. Thanks!

>
> >
> > Thanks,
> > Liang
> > >

