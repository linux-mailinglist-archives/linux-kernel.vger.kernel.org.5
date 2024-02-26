Return-Path: <linux-kernel+bounces-82145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE423867FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E281A1C215DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D012B165;
	Mon, 26 Feb 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S82QXTn6"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAE1DFF4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972739; cv=none; b=lF0apfkCNLvBW6p7Zb6KATlGGGqacfk2U5LOh0GT/WeT4AzIhMIQOJA14xKxbHf7Rqh+/CLWfqkg5A3X2/rI/AcnbLQChtalB+DIxxAVGuNl+EK9f3qDp6CruSJsmxi2rwc1Z+HIRZ2tjkjsKl+/vsWImvZebjDsjTXlFD6dIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972739; c=relaxed/simple;
	bh=yAb85nx0BPxN93fLWrvELpTgUdlrq5dRvyxHvqfOuX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEUUotmuiRXHW6anJ7cH2XAzguKtdDtZ13oHabH/1WLY2EblHvd8O/hiN/bBEDpzLoVDJpCuXym+CW6m7M42+2NTJs3lLHcrV/dRfoU+dArDyUcW6ILDp9+hhcX87B9nyw79dAgEHUopMsAQqdJzMuLlteERtsAS1PqmlsGEcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S82QXTn6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e4e7e25945so1571486b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708972737; x=1709577537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PnlJgZfLcS59z9QT2AxSLhFdZdPteoPLnCZaELPVAY=;
        b=S82QXTn6JYQKCYOAzvn7MwyauUm8yFjP+VX6oWaCPcSvBPRDO/z4csvB7qqYNvYp4c
         zf+VnZYiwbGiASZUUfMRHDBZT1yLagW8eJs+7RNduAmv9tKl7eWaulVxDk1SAGJ39MaH
         m8RTfAloZw47WN3MZXBerflSkvaLRjqVxP+xsn2HmpK2+XkCADDOEhvP3glpR6tTT1NS
         +W3JRxsWpKd1NgHpd0oDYpQZjJ9eqEJ72360Fw15CEz5o9IDvqpr42W50bLnj6zPH8BA
         fMCUGG4rCQ2QX9qvyF8vAA0k7eh5JI68xi20nBNqRajsnC4vkkvoqMMm2IfQUCfqbHrW
         Ntnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708972737; x=1709577537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PnlJgZfLcS59z9QT2AxSLhFdZdPteoPLnCZaELPVAY=;
        b=QzFxMcPMJvrxBoXhYAjCJzR6qM2i7hyiPt501vgOmyTCOVq/pR49amJRUpRwk27Rzi
         R0sEq95qPEFbVuTMXOyLQ2GMkjmzrAfCoZITa+NHefQQrf5LgNmQxmiueFH/x8eo/6xn
         Ipsz2D4Mk5HEYw+imupVY6R821vLuXQL01Agv6I1b0jtNzWSNXGwoI+J9gQX/2vEtBBr
         TJcSNVSJcf/7x3CbyLb8jX5Nn+xuAll+COqKkfs0iVH8x8p+onw04iL/IK9KJN1M7L0g
         U1AhkQZZct73IjyAH2eU/t2F70wMRcEeBIupEBqqHuGGASXh9dp+S4oCqsTbabo9nnWv
         HXow==
X-Forwarded-Encrypted: i=1; AJvYcCX5uhVqqlY1NQncXyfCQfqwbgcj+FDf5duWFNkKRPKOdUYcPbaCXjnq3dQ/Ld6srm5XPxCwCBAhdarBpthtRoNmI0AdFQ8E1AoJIJVF
X-Gm-Message-State: AOJu0YyW7+3e0FIOfN4WSEtRfIy2DuCJh4FCGrtGRHElVy+ze47H0yZE
	X/in9lMRSr/l7Eaue55fC71wPIHAvSZlFBjLXRbo1dQVrxwrv3xk
X-Google-Smtp-Source: AGHT+IEdqMdmXpVFgTAlu8XJDk/5pqJjaob553qYVsC6bnMTtImvjtlJ+djX40EQTcBymXiYtHLPKw==
X-Received: by 2002:aa7:99c5:0:b0:6e4:7a93:b627 with SMTP id v5-20020aa799c5000000b006e47a93b627mr7518618pfi.15.1708972737209;
        Mon, 26 Feb 2024 10:38:57 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:31e4])
        by smtp.gmail.com with ESMTPSA id l64-20020a638843000000b005dccf9e3b74sm4306893pgd.92.2024.02.26.10.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:38:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 26 Feb 2024 08:38:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement
 disable/enable_work()
Message-ID: <Zdzav4yCFI0kAx7o@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAOMdWSKrcRFUsFc3a0+2Js5hOA92xeQSkS06oL9VgSyZpDrO8g@mail.gmail.com>
 <CAOMdWSLjk8pZUgM6QHdeJ3C8Q-Y07GM4QuaSyAyP2jZcAMLOhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSLjk8pZUgM6QHdeJ3C8Q-Y07GM4QuaSyAyP2jZcAMLOhA@mail.gmail.com>

Hello,

Sorry about the late reply.

On Thu, Feb 22, 2024 at 12:26:35PM -0800, Allen wrote:
>  I do understand the work bits, but I don't fully understand the
> concept of colors
> (work_color, flush_color). A swift overview of it would be highly appreciated.

That's just to group work items for flush_workqueue(). Let's say there are
work items which are queued in sequence, 1 to 8. Let's also say that there
are three flush_workqueue() attempts which take place after work item 2, 4
and 6. Then, the flush colors A, B, C, D are assigned so that:

  work items        1     2     3     4     5     6     7     8
  flush_workqueue            ^           ^           ^
                    \-----/     \-----/     \-----/     \------~~~
  flush_color          A           B           C            D

and the flush_workqueue() code waits for its preceding colors to be drained
to implement flushing.

It's just a way to keep track of the number of work items in flight which
were issued before a certain point in time. It's expensive to do that for
arbitrary number of points in time, so it just has N slots for groups and
calls them flush colors.

This shouldn't really matter for the bh conversion given that everyone
operates on individual work item.

Thanks.

-- 
tejun

