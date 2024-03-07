Return-Path: <linux-kernel+bounces-96371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74559875B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F39928356D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B247F5C;
	Thu,  7 Mar 2024 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EhekeZZx"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1F3FB2F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855554; cv=none; b=fggZBbSgDq1qSzDep1nvo2JgOLFG532qtsiFVTmSx9jAIR9x4sy/VTfgeLI2ewowykLEym5DYxy8+zVO6bV9Ytif6GyqKNkwIKTxQ0NcsjCJU7AxFkl3WQYvna7bWQRvKook7yB6pNmhO/xzpyeclbEXzfyyREDkjLm0NgL2JkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855554; c=relaxed/simple;
	bh=rrrE288GGqnOFkITVQ6l8vfzosgPyL+5gwpnGsNXtEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hEifRjr/Dc7TBg/zP6qqyYRdinZSDnm9P5VVSdRTUO8HZE6aa1u2V4RtnEsrVjRj8itDhfGNFO/QzrrZeI6c7DGG+hkAKv7QK03tF3xnP/HRE77LuCtxpwplxtpBX/y//k7KYFcmKN0UQT4bvS4I1aGBNSF7Qk97E3MJo7bqFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=EhekeZZx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2991e8c12so15140651fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709855550; x=1710460350; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrrE288GGqnOFkITVQ6l8vfzosgPyL+5gwpnGsNXtEM=;
        b=EhekeZZx7ulzJXjlimX6cE7fVhGadcX+0+4wdR20hGsgBQbolvBe808ru1HQwlhFZ5
         5v4/pFYBRZwas2MBdP6YMDU8r6/0SfztFwnfsFZFu5u9AWEfM7CLHMwvkU4aGiU/P5ZC
         qxG4uUJyBLQ3QulPBIgLr2geOy3d8N9URj5tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709855550; x=1710460350;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrrE288GGqnOFkITVQ6l8vfzosgPyL+5gwpnGsNXtEM=;
        b=FW/+ju1bEyLthLKsVUP7x/IkLLUnzEoG/yCif1AUz3/QP/5DLTV73p0l1h6aNSVVLi
         aPAhUSRhaaps4SsL5Unwt07BFrhgdLml3lkpFJ8HcJf/Ihr+Ex+NcOvhw3qOv/eiF50U
         UDWJRaenGdtlI7jM1a5LMTrhEV3Ondv8BIRJWuRM4ufKFQhoLfq2Xrzkf+rXkcJdazKw
         evFgG+ipvsHepbvzW005DlJYHoVPIQPCV1yhA6mMHk+324mM7CbUZPJecoWfMHNJeA9N
         DcO6SSaPPUL6c/iixBivpPsu7h0csu1a+NjLJ3wH/mGg336Udu+PDQ4aHJax27zjUe/x
         o7rw==
X-Gm-Message-State: AOJu0YyITQhqyPrGKqfKpaXiqKdsujgJ2oln+U2YE1NevMFLhpMRkKHH
	pw3K5HQLjSkORLfymp6/2bkKYG7/pSuEJkm9gu+DXQJ0HR1PBPzNgLKfki+ofhZlKG/VNO/wKjr
	uTmMD9BlCW+eQrV8ojUM/Ll+REGtnhvxYRMQbpw+ygAPPRFLL
X-Google-Smtp-Source: AGHT+IGwE8AFVxTKrwVEKeSVNA5fVRjhIMcv4GE0U3qh32bzUdIr8/Jz4yM8wQjU8QgMQHPbiKJux0YVFsOIeFz0iFI=
X-Received: by 2002:a2e:7809:0:b0:2d3:ed17:1f53 with SMTP id
 t9-20020a2e7809000000b002d3ed171f53mr1154509ljc.19.1709855549963; Thu, 07 Mar
 2024 15:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307234852.2132637-1-joel@joelfernandes.org>
In-Reply-To: <20240307234852.2132637-1-joel@joelfernandes.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 7 Mar 2024 18:52:14 -0500
Message-ID: <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
To: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com, 
	urezki@gmail.com, neeraj.iitr10@gmail.com, joel@joelfernandes.org, 
	rcu@vger.kernel.org, rostedt@goodmis.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:48=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> In the synchronize_rcu() common case, we will have less than
> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> is pointless just to free the last injected wait head since at that point=
,
> all the users have already been awakened.
>
> Introduce a new counter to track this and prevent the wakeup in the
> common case.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Forgot to mention, this is based on the latest RCU -dev branch and
passes light rcutorture testing on all configs. Heavier rcutorture
testing (60 minutes) was performed on TREE03.

Thanks.

