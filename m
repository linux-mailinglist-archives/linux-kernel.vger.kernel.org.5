Return-Path: <linux-kernel+bounces-103589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F787C17E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A821C210F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9207353F;
	Thu, 14 Mar 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUvRtukr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C132E410
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434836; cv=none; b=euIjzk/PZ5k1eg2jCsJD94XD3Tp62sZGQow/eELJ5aLh0sSHcfT3toCIfjOxjSgCjopjMSgHFoNETKOZMt96RDE77kovllO7uCnqAHlREqy7H+9dK/CqALteivvtqdWueFdNYyfh1Wm6NoJMW4t3GgVmPQO1tfIcXspBC6uB3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434836; c=relaxed/simple;
	bh=Kh1ZlKsEdhI46j9iCWpyEXmZE1DoJbYDktZxNP3r+iI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHdDMScSxoLAItomeucV8WNpUo0uodWy/bi5bDVtpfatLuvy9S2xFSPYw7SJYHoE3bu37Hyzu7EOKD5sRqeams2jJohZ/fQg5130qe83wx9YUsxbf9IJHkpyRi743WdKuWY9RuA1aQs0zCGuq0MwPdq7WkIKRP8FKl65xtm3mxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUvRtukr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710434834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kh1ZlKsEdhI46j9iCWpyEXmZE1DoJbYDktZxNP3r+iI=;
	b=EUvRtukrNgjd59vpuTgus75CTlsPK6a/DEeZfDFTkKDL8/0Qt/JQgnz5Cz/SRl/jq8X1VR
	T1PVvrifCRCcx0sza/aX+vqtKdQyjKMbY9jO7DJroPvcZVk8GQY4aQx6xNkAViIjo0b+F1
	narwIPjQnEn9rs5Cr7E9b+GfzPDK6tE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-MmKWkpwNPw-Gzl5qjn2wiQ-1; Thu, 14 Mar 2024 12:47:12 -0400
X-MC-Unique: MmKWkpwNPw-Gzl5qjn2wiQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4308b2e8991so9648941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710434832; x=1711039632;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh1ZlKsEdhI46j9iCWpyEXmZE1DoJbYDktZxNP3r+iI=;
        b=N5Ccz/pLXosBJdSuPTMfjAZ+Y5FSwJLHCir2D7EBxsSFNxnjkzUAo8QHZuslfyarJR
         KZR87DsJjD6KyVnnixcCO/8DS/ZMlmZf4Du5lZbcv/P53Fi1Q7IOUBwQxsFzGsg2h31W
         CtEccjV9fj8dtC+jxfefsgl1JiyLO30n+evnr52qKVpjsrcISadkTs/03zt58AAqXDam
         1C1rJEyFFTwhdujAb5536gMA6OGKeU/fs92JjPKss2qNVeBIVqjG384AnvBoSHpg90gp
         1+6SzdwZzpdupIc51KWOBpisNUP51H9t8jQpHIsoQBUpbEwlln16ZVeDCfv3vcQe36yW
         2PtA==
X-Forwarded-Encrypted: i=1; AJvYcCWLIiHjSG3Ltdu53onVP8S5mEIt6DqHP5RWJK8JHJgRJJKqSBtXVKML8dOh++DVAL/sQ1DBh5HC7UI3eLraweVdYTsRTiLCz1mUqR2F
X-Gm-Message-State: AOJu0Yx71Q3kOU7e+Jcu4QaYiH6jfEADdE0Uf6VqiJTmcBiX88dq8Rq0
	2dlMkk1vXOk+IkIY0pzD8tI8o6QQrYKa0vNZFAHo1sxic1dsJWfQnFE7Z3giYrEzSnc15JbOuMp
	wU7kggjM+pUhDA5YNF9o5nWdJuIkua95n9A3ZWaxUB1u1a1xs1GFdHsmYEpJ7yA==
X-Received: by 2002:ac8:7e8c:0:b0:42e:d10c:fca6 with SMTP id w12-20020ac87e8c000000b0042ed10cfca6mr2589705qtj.2.1710434832222;
        Thu, 14 Mar 2024 09:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3daTMVU4OKE/Vh69+qikOo9sHz+xCP38/nEuSpC6xUZk1uD+oE8hURSbry8eOWuImtumqOg==
X-Received: by 2002:ac8:7e8c:0:b0:42e:d10c:fca6 with SMTP id w12-20020ac87e8c000000b0042ed10cfca6mr2589644qtj.2.1710434831630;
        Thu, 14 Mar 2024 09:47:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id dn17-20020a05622a471100b0042ee2bda028sm583008qtb.54.2024.03.14.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:47:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
 linux-kernel@vger.kernel.org, nysal@linux.ibm.com, aboorvad@linux.ibm.com,
 srikar@linux.ibm.com, pierre.gondois@arm.com, qyousef@layalina.io
Subject: Re: [PATCH v6 0/3] sched/fair: Limit access to overutilized
In-Reply-To: <20240307085725.444486-1-sshegde@linux.ibm.com>
References: <20240307085725.444486-1-sshegde@linux.ibm.com>
Date: Thu, 14 Mar 2024 17:47:07 +0100
Message-ID: <xhsmhil1odalw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/03/24 14:27, Shrikanth Hegde wrote:
> When running an ISV workload on a large system (240 Cores, SMT8), it was
> observed from perf profile that newidle_balance and enqueue_task_fair
> were consuming more cycles. Perf annotate showed that most of the time
> was spent on accessing overutilized field of root domain. Similar perf profile
> was simulated by making some changes to stress-ng --wait. Both
> newidle_balance and enqueue_task_fair consume close to 5-7%.
>
> Overutilized was added for EAS(Energy aware scheduler) to decide whether
> to do load balance or not. Simultaneous access to overutilized by
> multiple CPUs lead cache invalidations due to true sharing. Updating
> overutilized is not required for non-EAS platforms. Since overutilized and
> overload are part of the same cacheline, there is false sharing as well.
>
> Patch 1/3 - Main patch. It helps in reducing the above said issue.
> Both the functions don't show up in the profile. With patch comparison is in
> changelog. With the patch stated problem in the ISV workload also got
> solved and throughput has improved.
> Patch 2/3 - Code refactoring to use the helper function instead of
> direct access of the field. Keeping this patch so patch 3/3 becomes
> easier to understand. Depends on 1/3.
> Patch 3/3 - Refactoring the code since most of the patterns are observed
> are eas && !overutilzed. Changed the helper function accordingly.
> Depends on 2/3.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


