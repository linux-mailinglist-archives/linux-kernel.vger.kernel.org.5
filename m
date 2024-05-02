Return-Path: <linux-kernel+bounces-166677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6118B9E02
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B000EB23E0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDBC15CD50;
	Thu,  2 May 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm7t2+EC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F715B96E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665679; cv=none; b=bXIERlaSJSPccjmJ2fMqwsCItoUlb6DW7dc8/rBQctRHie+W5aag+8OYoRaT/UHqa8xdiUkXN0iDgTUeAh7ImnaR8elaavZ20LrYBWX98P0TCZHDLqbSB7ev2EnmJO/m2Cx5efgXf/iv0M/aZq4Kf9hCI7dg4EQ06GrXDDTJOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665679; c=relaxed/simple;
	bh=IhD0rDHV3h/lBf5nlZl3DpdpV0Xin40o6FVukWjfTBo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POd96Rkz49quWIasLIYDGE1Y8ggNGu2aghFyysFNfxw5lBZSRrhBz1cT06YS22EMOp5ziszH+YCE54lN2kWy4Jp7duht4CQrYBvureGH3NvPc4NLpA3fYZ8gENweY1hSYD4YYxRLE0gKG6GAT3LZt129itZrxUwmwWkPG7T7PuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hm7t2+EC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714665677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6edyJ6hV9TOHyvn25sORnvTBodZ76gZq803uAR4x1c=;
	b=Hm7t2+EC8xKCCYIWNze5VIsOuV0wrH1dZylScwvB1uW9iZQfvQqb2bDjrnS4VZgxnA6zF2
	GLL62vAsPoVdtfqrDXa3gMJePA19z8to43FpLCIHktZlR6H/cewa+LU4QR7sNrBLNpWJon
	lnmzTd4Ds60oyPs0qi65eRWEJlnY0BE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-e0xI79UIOu2RLzurCv00rQ-1; Thu, 02 May 2024 12:01:15 -0400
X-MC-Unique: e0xI79UIOu2RLzurCv00rQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-690dd4cf6fbso78925696d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665675; x=1715270475;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6edyJ6hV9TOHyvn25sORnvTBodZ76gZq803uAR4x1c=;
        b=TQCsd0tdkO5XDdWY/YhOllJrnQ7e+zeqPX61tzj39VzLeBUE05eyJCwKIuL6HwEB+H
         Tqa6uUdrzt0YLnRwWBBvZV4JErQVz4oi9gxnH98Y5bi0cFMi4yO1lK93S+hIj+p5aYnZ
         rUwYSZSnLVJF/fhQb4JiWVy61N8S5KeIWSvtfR9cuzC5FboNVIImF4vEIMvA6dErPsMM
         kaRdFXP4EI0G9WyQ3JnG1iF5dLDrsBB+rrxUBh6QGwWARARQCkviLIlTfdFgNg4NJcEZ
         j8eIzNuL0WAwjZtHAwt5m3XDZDMrOv5xP5YhNErm9v2YmPq/m+0/q7eTz1zB2EZzVfkx
         U4fg==
X-Forwarded-Encrypted: i=1; AJvYcCWGp8cYJuu87Eal1u/y6Wp9tqbxfBLYeo66cZGreTYjPMVueS3qFMFgt9ZlfJgwhKUEpvc7+kRIscTzYfO7IuAInN65PSRzgmiGpmDB
X-Gm-Message-State: AOJu0YyZqnD8kdosQU6pX+7X2LvdGQFsb82cVtcbF5u5/gYMaDcL+/3j
	fVMKeLCZ2XFgGEgiSRXmT2Lg8NFTKwpR85aaME2MmRAnnFWgtLDlV8AH9HR1+HjABbSY4zMVrVx
	D/rF3+x8/g6n6RgXsEEqdl4OoD2H1tXhH0RTIrHqHrf0CVjFWVrS3rU7eiSTX3w==
X-Received: by 2002:a05:6214:2621:b0:6a0:d581:921f with SMTP id gv1-20020a056214262100b006a0d581921fmr7080153qvb.42.1714665675065;
        Thu, 02 May 2024 09:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbgRcW4FkIzpDJC/LKrU/iB8E9O6pCHRc3QCn0KlWft9KyoKC8okXZNqcdT8QHzqE8cS0hDg==
X-Received: by 2002:a05:6214:2621:b0:6a0:d581:921f with SMTP id gv1-20020a056214262100b006a0d581921fmr7080061qvb.42.1714665673719;
        Thu, 02 May 2024 09:01:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id j2-20020a0ceb02000000b006a0cb1b9dfdsm452229qvp.5.2024.05.02.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:01:13 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, Vitalii
 Bursov <vitaly@bursov.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] sched/fair: allow disabling
 sched_balance_newidle with sched_relax_domain_level
In-Reply-To: <bd6de28e80073c79466ec6401cdeae78f0d4423d.1714488502.git.vitaly@bursov.com>
References: <cover.1714488502.git.vitaly@bursov.com>
 <bd6de28e80073c79466ec6401cdeae78f0d4423d.1714488502.git.vitaly@bursov.com>
Date: Thu, 02 May 2024 18:01:10 +0200
Message-ID: <xhsmhttjg6w55.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 30/04/24 18:05, Vitalii Bursov wrote:
> Change relax_domain_level checks so that it would be possible
> to include or exclude all domains from newidle balancing.
>
> This matches the behavior described in the documentation:
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
>
> "2" enables levels 0 and 1, level_max excludes the last (level_max)
> level, and level_max+1 includes all levels.
>
> Fixes: 1d3504fcf560 ("sched, cpuset: customize sched domains, core")
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


