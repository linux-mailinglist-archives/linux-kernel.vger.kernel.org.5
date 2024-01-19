Return-Path: <linux-kernel+bounces-30870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49283254F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09001C21FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18ED52B;
	Fri, 19 Jan 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcQN7NN8"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488F8F6E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650962; cv=none; b=dJXFhFPtpKib6GKQG8q5jknsAUN81YwD5obYnEtRbXiF1H+q4rA4oQBuDmkiZjYivt5FhlauLCYS4t51/L0F6oxI0XfadeXI26288l49thqsoyp51yZ0hTYxedpNAgYGj8UP12RXISAmRTUKKF+9+YedxqmVhTR/53yjgdfT/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650962; c=relaxed/simple;
	bh=6V5XZisZ4GWoTJ991u0pDnTPO6Gubo7F5/ErXbiQ9/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z267JIETr1F3kPLduuaEud+Wy8sEd4GEGugd+UYLIpKvaBkgIKka4UeTiDQAL+5iwmkEME0+5qTs8W1MiQuC24NskNqXhfInbev6MwhVtNeSqHyza5LF3yyiYGHR8T72d1aNC8M5M6dzyMDTKjRKVFhDUS08OlyBEZIWs4S7HIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcQN7NN8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1180386a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705650961; x=1706255761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p/QzznUuwdyqEAl4teM5oaDQD34XWmEBMBut1QG2Rk=;
        b=JcQN7NN86zLCiq2ySbQa6G2J4qOhXUkSkhZceeFsiFECa45ZRDVGqe/XeboCLOhgwG
         TzsKNJA+IFTwqqsrdD6AVIX8ecfsK7vhcM4s50Lx8jfsWMy1FqlckRe/olaPJLvvY2MQ
         rxoFKsuvlxFdozG6KAIbjNnWQt0RQqAewaqjUNkKYMnFIbPyq8X9Vmpi8dZr9+5WQRgm
         /rYOieHJiWE36fJMJU3IGTK1pf3X7rhaFA7hI0V+jtaW04DHihEl774OXb07NN19Ef6d
         Dgu+gjpgqYVlY/FvLRTesMhYrRN9S/evxmPbAaFRNLr8Ta084vipMnPUCvTYSdHb9lhg
         MEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650961; x=1706255761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p/QzznUuwdyqEAl4teM5oaDQD34XWmEBMBut1QG2Rk=;
        b=Ffyb2IM6SNCykpJt8/exnKZ3YKB1mB01PgkkfwMbPWTibpUIdQdwLo46g5ILDKrkfP
         qW2n8Sh0diaRQhD0+Rac3x8kKeH+KYAz1WfYpF4uKPXTJCmp37ywdOqFbzoLMGtWhJTg
         Np97uxVZ21ly0bxlrBl+p4SfQyGkqpI3tyHLfGTaVfIrDtNSf1oLXk+eAp4isclv2qdq
         8+nVy3bENLHH1c5l8Nbuxe1TP//lclNkbA/hgY2pV3hys+seDTH1sMbl0FX6q1gmq+QQ
         nysLscgswN7jN4d4sGzHLeOEiLlF7TqsVbMihWj2B5hqJLqj93AX8YUOS292XFGL105e
         iSgA==
X-Gm-Message-State: AOJu0Yyfs0nVqQdSiirQjFcNEpvpmGXDiESXDUKNUb0sNSez46UqrEN9
	/lrhiZgR5A0kiAnSNekB6QLXWTDM6I42GAVK0iWi3nVzxqcKnIVSx6Yd/g5318vuraomJtsf6hf
	i7hZr18G7hZnmLUKtra2TsbtXdGl9dHL2
X-Google-Smtp-Source: AGHT+IGbQbtf0NA2VdJWPKmqCG5jj/NljQ5R7wuPY/ZbGQlbcWtDPeh5jV8Gc9+/umTatOGLJVDZ5qdkg5p14e1Bivc=
X-Received: by 2002:a17:90a:eb0e:b0:28d:950f:f1ca with SMTP id
 j14-20020a17090aeb0e00b0028d950ff1camr832614pjz.2.1705650960778; Thu, 18 Jan
 2024 23:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113002911.406791-1-tj@kernel.org> <20240113002911.406791-9-tj@kernel.org>
In-Reply-To: <20240113002911.406791-9-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 19 Jan 2024 15:55:49 +0800
Message-ID: <CAJhGHyCc4trDp7XQixt0EmTnwd-2fdH2hn4fH=wKRB216MQssg@mail.gmail.com>
Subject: Re: [PATCH 8/9] workqueue: Introduce struct wq_node_nr_active
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Sat, Jan 13, 2024 at 8:29=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> @@ -327,6 +337,7 @@ struct workqueue_struct {
>         /* hot fields used during command issue, aligned to cacheline */
>         unsigned int            flags ____cacheline_aligned; /* WQ: WQ_* =
flags */
>         struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwq=
s */
> +       struct wq_node_nr_active **node_nr_active; /* I: per-node nr_acti=
ve */

flexible array can be used here.

Thanks
Lai

