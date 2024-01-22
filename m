Return-Path: <linux-kernel+bounces-32799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6D836030
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5F289AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F43A8CC;
	Mon, 22 Jan 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DFi+T9kK"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D23A8C0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921083; cv=none; b=U8Xoq39fYBortFu+wdlozD0zZiPyJAMUjbNvPoPGpVPyB+ODlIIcTXq4USwDrbWwWOPosXwluqxY+PXvWFfCVZX9wevNDpK+RhVhvCB0TqUpYuOfCtkRR27o8Lml+2fo+ij6bscL5GcnopUf/kzedvbsjsdIctta6goDYGlWiMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921083; c=relaxed/simple;
	bh=dq/j3A67sRPpENRKDDsHZpKZNgsUWcP1mECMFwBigvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR7Iupr9vj8p2ee9sxAZ4cLpFLIU0/tVz6EvOxOEPZ1ynxsRKD2faN4qrmOLpWkRj4VJLGw0olKiSoNyIzRcvRZ0BPWkOrx9gutYvRlpUQD+3UR6/KnqhcyVJ57+oa3oXqhTLFRGUoc/jtk1ZCN4NvPpz8M9h+0SaDTFNdet3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DFi+T9kK; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-594cb19c5d9so1687331eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705921080; x=1706525880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyrL3W6llccgMrgGVcBgvlNKkqQHZ86nYnIjTDXIxtE=;
        b=DFi+T9kKZPbrHqZfqTaduHailMNOVqnXk7UCWnHxsxE4BadTu16WJOi15nxDNtglAE
         v33nlBDXvEpksZ44YoYspIj/7Ijmn/xZViCGYyl5kj8JiWaY6LwoKqecHpmMsAyxM80Y
         MLAZKCYV/nMJWV77YVnT3looolQ/uRjfEUaqqN6KZAUp5b/tBWiKdLkFa5cbGmZ/sbI1
         lswhE/vH04VlJSskyBv8t+GhlgvPTSg/mZDd8+wa3TfLMY1+Sh4oIqmCzmwqIlX+m39i
         el3hQjtIdGyhcNO7NuxrQTt06hy33Wm3YtDQUnmefTPKSh4G5+TaTQ1y09qDoA3zJkQS
         ULwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921080; x=1706525880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyrL3W6llccgMrgGVcBgvlNKkqQHZ86nYnIjTDXIxtE=;
        b=R+/JcJFduoCKPLBSdVQNHoM0PWxTw0Q1YW8L7HtQHaojw8VeYLXKxt/yMf2txqvc/U
         pPyH7JnxtqfX41HGq5Aloi5d79BQBYYFHfcf9fGijVcb5Jxvi7kBfVvPYKnY+CCnfuXK
         doavi5YnjgV/7GYuL38Rwemcshqgl8LyC+qwDILNd18vVtL2V2fyPYebJYq3CInDlVoM
         v3aV4yUyNa5FlJwNFTaTKHmFv8Qz5QzFYWz/dNS48ERKoXWaUDR1xgm7oBjsF4dcIVEH
         kVe4khxccOO9eKXmAEPQzcp35IktyOYgTYE76kadfJwiQL1EV7GfA59aTx+VN6DnuCrg
         EP7w==
X-Gm-Message-State: AOJu0YwP03hU6AxQY6ApqERpnmmQ8A6mkYs/iqyw1ZndHJoKoQfLfGk3
	r+WwS0joO3bPUI4ro4SeX2fWXBzCQ/1z1OIbNtL1f+/CoplRpakLUzQRFIHRHlxYuSTEJF5lzi9
	z73xb7SECKwDl1Os51wDM6zaZa5EwyJSNU4Epcw==
X-Google-Smtp-Source: AGHT+IH/zbah4ktUS7RBxnUb+QZmXGB6Q0Aw2aF+Gzwvh1cuixikSER5a9dsCCz8OiPNs+wmNhu04fK2CIxYdOaBVuo=
X-Received: by 2002:a05:6870:2112:b0:203:7522:e0db with SMTP id
 f18-20020a056870211200b002037522e0dbmr2055647oae.19.1705921080618; Mon, 22
 Jan 2024 02:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122013510.55788-1-cuiyunhui@bytedance.com>
 <20240122-boxcar-conical-c728a709aa5c@spud> <CAEEQ3wmX7_VP-YM9NkesAhd+5zetw79AW9bo0YO7KGAeJX4eRQ@mail.gmail.com>
 <20240122-jawline-handling-e190c90ddcfc@spud>
In-Reply-To: <20240122-jawline-handling-e190c90ddcfc@spud>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Jan 2024 18:57:49 +0800
Message-ID: <CAEEQ3wn3vuPMG_=6skXcXNvnktv767nAENp=wmXoD_MAi7EuPw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: cacheinfo: add init_cache_level()
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	conor.dooley@microchip.com, robh@kernel.org, sudeep.holla@arm.com, 
	pierre.gondois@arm.com, suagrfillet@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Mon, Jan 22, 2024 at 4:55=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jan 22, 2024 at 04:32:15PM +0800, yunhui cui wrote:
> > Hi Conor,
> >
> > On Mon, Jan 22, 2024 at 4:09=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Mon, Jan 22, 2024 at 09:35:10AM +0800, Yunhui Cui wrote:
> > > > When cacheinfo_sysfs_init() is executed, the general weak function
> > > > init_cache_level() returns -ENOENT, causing failure to add the "cac=
he"
> > > > node to /sys/devices/system/cpu/cpux/. Implement the init_cache_lev=
el()
> > > > function on RISC-V to fix it.
> > >
> > > If you recall correctly, I asked you to explain how to reproduce this
> > > when you sent the patch.
> >
> > In fact, the reason has been explained in the commit log. As for how
> > to reproduce it, you can check whether there is a "cache" node in
> > /sys/devices/system/cpu/cpux/ on the riscv platform.
>
> That's the thing - I tried to reproduce this several times and either:
> a) The system had cache information in DT and the directory was
>    created. If I hot unplugged and re-plugged the directory was
>    re-created.
> b) The system had no cache information in DT and the directory was never
>    created.

Indeed, I verified it again, it=E2=80=99s because there is no cache node in
dts, thank you for reminding me.

Thanks,
Yunhui

