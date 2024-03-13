Return-Path: <linux-kernel+bounces-101636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DF87A9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F234B1F228ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C67483;
	Wed, 13 Mar 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KyTny1Qe"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30B46A2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341253; cv=none; b=GKxOANcqEHJUM2bek1/6q2mde4M3t3ZqQb7vCiaCbQDad/F7awEIcqMazZ6aS+WVn8n7o6M6vGaGoUTPhjXXHEKjaiLSxFdO82xXBK/6I4jRoE8OQ3BWk4mUXdXwN4nPOrwzrH3RKXBMHWWJ21S4qfIp0Q0LiKEBtyT0HFt3SaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341253; c=relaxed/simple;
	bh=YzkqaXpaFRM8RtDzrlCxHkAAJsnVwNrP+emQe7yxPRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YD3hXIm4ARAJDDWxbms1mo2Pwsg24+9X84qPvmZNk9ui/kzrKRYydB+etnYDUrTAKBVWpg6Qk6wyy02xRUE34b0N0xAWHP50UZdmhBpuLNLuWVJmj1iDEOyLCa+e8Ec/MKDNqpNUPD+sCEqnfOXnxLizPf3v7iqF9g1InQglUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KyTny1Qe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46692ec303so14240866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710341249; x=1710946049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YzkqaXpaFRM8RtDzrlCxHkAAJsnVwNrP+emQe7yxPRQ=;
        b=KyTny1Qetg1Ps+MEj02fDBNNLtgHg08VT7H6QptZkO9h/WejNlfrmCU6tEjUe7hTcL
         YK2uk7DLv16Whtgmb/qCm9aCmQPcNjw7J/wd+NuHoxGoWNde/Mt8wzLhnYWZu+wyvPYD
         o3Kz8s9OZAx9rVycrjTucbMP1g9Dt9L4DsEno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710341249; x=1710946049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzkqaXpaFRM8RtDzrlCxHkAAJsnVwNrP+emQe7yxPRQ=;
        b=sOBwzG8YsryuL9qTkoqZdKJw1CdlxMwUKUGqWOC+7kelcXGnjLKz98X/3rm9H7EfD0
         bfqWGvNtEcPsuc0BQlRIP4sy5hqtvR5p8AtMNGOh7Q1k5gOMAUBzhlBKd0301ClX8/I3
         6bOQnHkm4kPH5+SEE4kArXC/MVNf5JVIxDOJtgNhuQNVN4Jz5sfRRijqArXxsUwBlzhm
         l323uLro/nLiDCjXcL4n1OiUVOA4XPDjh+8tEEiUCRzIxFRfFiK/pHQnN4y2c9ibFU7r
         K0eL7Rs7UzH2zTLz3zX08YkcEFj0h/EI08c63heaFkaPxv+8aZHpnTKH+PCDSBvGkcfv
         i/5w==
X-Forwarded-Encrypted: i=1; AJvYcCX4KaSC0nG3VnUN7MM5BTyMzmTjivqbjsEaaVzjwbZsWuFcjs85Q7cKrSNiygXSE5c5mZE5htaaY3m9IGFDtCdOK7azcDXbbvgr+0UT
X-Gm-Message-State: AOJu0YwforagUW/3MfP6hW3AJPLdqitmZsyYVBYpEBNeYRLiDDOoFwWi
	ngqOR5wGgHo2p3gPReDgi89iAlVeSFs2YXb2937raFtasw4KaLFzHWNAQZliv4wDFdpyhxllhIk
	VgvV3V9OO2PSiceeEbobSa0TqoVmKWXZsiR8LTw==
X-Google-Smtp-Source: AGHT+IGySR5X6+YUZKH2Phuq/Y7qs8aoKb13avqzeIMqppT7+EeSbdOV2V89Z2OfDgsEw2J1JOH6R/o6+3Vdsa68KFA=
X-Received: by 2002:a17:907:972a:b0:a45:f4c2:38d7 with SMTP id
 jg42-20020a170907972a00b00a45f4c238d7mr9051453ejc.18.1710341249573; Wed, 13
 Mar 2024 07:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03d7a29c7e1a8c5741680ea9bc83b4fb40358a25.camel@elektrobit.com> <CAOQ4uxg+RveBHjgui_HjCasYGor3JNeuv-UroR=5j4n6TgRd7w@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+RveBHjgui_HjCasYGor3JNeuv-UroR=5j4n6TgRd7w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Mar 2024 15:47:17 +0100
Message-ID: <CAJfpeguBfKB4MGEUkJ=+ZFT9uYJ1DXtCTW9oLrEE0af7XTi=VA@mail.gmail.com>
Subject: Re: possible deadlock in ovl_llseek 27c1936af506
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?UTF-8?Q?Wei=C3=9F=2C_Simone?= <Simone.Weiss@elektrobit.com>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 14:14, Amir Goldstein <amir73il@gmail.com> wrote:

> The reason for this report is calling llseek() on lower ovl from
> ovl_copy_up_data() when ovl_copy_up_data() is called with upper
> inode lock and the lower ovl uses the same upper fs.
>
> It looks to me like the possible deadlock should have been solved by commit
> c63e56a4a652 ovl: do not open/llseek lower file with upper sb_writers held
> that moved ovl_copy_up_data() out of the inode_lock() scope.

That commit is in v6.7, so something different must be happening on v6.8-rc1.

Simone, please send a new report for v6.8-rc1 if a lockdep splat can
be reproduced on that kernel.

Thanks,
Miklos

