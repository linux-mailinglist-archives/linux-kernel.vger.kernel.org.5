Return-Path: <linux-kernel+bounces-92185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5983871C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8679EB24B93
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDC5B680;
	Tue,  5 Mar 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaSS588B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61495B670
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635868; cv=none; b=dJs35EhNOKeytrHlxezVjzeTPhjdxkLpDHPjx3rTF3zY97866NpFh/n+v0kIF8tHcx7n8WV968IAYG1WMrWFMYScQ4RAsnnftfEGCqvvNqbjRtL9iNlnVYT66oWEJNnpLTN7DIvtUM936HWUaWEXokNoypcdJKPjRH/yJLiMPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635868; c=relaxed/simple;
	bh=L2vAZlUkFX5OuyFpN+ZnCRNF1u81oYKRy8h6L3yGTwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHGFEzcYnSH/+MKSFAtqVtzOT03arnTaPxmVc/3LTFHNqAH508HUbGL/Y8DAuG4nfAYll4u3ziYj25H7HXKKP6h5DFG3QCKiVnSfwOUZgPpWcR8JSG0dP+GItgqOj2cK3lYZXW4+tlBz0ML6crRsA/VFOcraZkhKD7+FXfAEXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaSS588B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2vAZlUkFX5OuyFpN+ZnCRNF1u81oYKRy8h6L3yGTwc=;
	b=VaSS588BXJ+rAU6CrP/ps+e2Jko55VTmqK1nJUHH46rvoXC9kJekN7qjBRPrQq+VxdlXkC
	zoJ8tstLWrBrm+63YnAh3KIN+mpaZY/qy28AtAIp1dAqnlgO/ycwq/nGOzjkl1Vh9n1OwH
	LRVh/+/KvrXnLkxv0emECQOOFLXXu90=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-hTGaln4WO76M4czSVNKF7g-1; Tue, 05 Mar 2024 05:51:04 -0500
X-MC-Unique: hTGaln4WO76M4czSVNKF7g-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5a112a333ceso3208906eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635863; x=1710240663;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2vAZlUkFX5OuyFpN+ZnCRNF1u81oYKRy8h6L3yGTwc=;
        b=gq9hgg085mEKuqGiZ1VwlbypSx+UfZzlDWyFecerk1b5m5oswZKSyuVxUuxlEwl8Dp
         XI+Lj+X+JqrWQUSyWWCcIx0/fz2c7/DJ+oR/opGdAaecPvY/nurzw9R6ENgHM4r3nLSK
         6pheYN6kN1NINuQh2aF2b36zCV4sdMNK5gkPrIgjrEmiOFADJnBYgLRE/ok906M9CSYw
         WJume4SBPr1mQY724Awprg4tx8XiJ0iX89VEXKUb1TnXwcXxHvaPXWo5QsgKkit3v/hS
         TP0ZON55nmW+zl0NCK0tJGrLSP9rokJAinBD9VVGLlLSSs9TRkAtoU2Rh9eZ7la4O9QT
         ZTsA==
X-Forwarded-Encrypted: i=1; AJvYcCXVg73H0KgWI2M9t8Q+2AHcyIGqV3kiigLr5FrJArbirBVlc+PPXygXSe6SOeKH7Smc9SGk36RXfXLvY8o17Wbl+7I+IaquPya+hryZ
X-Gm-Message-State: AOJu0YwE9XNLIJNkLKqNyDJTKE2SY+a1fRlzWo/MJBPKzrBuQjZ6J76x
	eyFvmpW2HcY/pmpIrvIUmN4IevOSTj30qRcMDBrAaxyhUdCQFTwR2Ae0j97fLM9fsfHmbojymFT
	Gjs88FSOkTHr+WiZ40JNJIZNUThAMe95yINXQBfJo8lyTw1PZ5ETxwDZkH5LTdA==
X-Received: by 2002:a05:6358:5910:b0:17b:5c65:7f99 with SMTP id g16-20020a056358591000b0017b5c657f99mr1358058rwf.1.1709635863485;
        Tue, 05 Mar 2024 02:51:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2ftRr/5kLivpJ1EJXyiYJ0J5tJkw2GgcgzW5rNqRPc9Xz5XtZEy851/d9UeoVnstLtCXEEQ==
X-Received: by 2002:a05:6358:5910:b0:17b:5c65:7f99 with SMTP id g16-20020a056358591000b0017b5c657f99mr1358049rwf.1.1709635863191;
        Tue, 05 Mar 2024 02:51:03 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id kr23-20020a0562142b9700b0068f52a6f4besm6037785qvb.103.2024.03.05.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:51:02 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 8/9] sched/balancing: Update comments in 'struct
 sg_lb_stats' and 'struct sd_lb_stats'
In-Reply-To: <20240304094831.3639338-9-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-9-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:51:00 +0100
Message-ID: <xhsmh8r2xdka3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> - Align for readability
> - Capitalize consistently
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


