Return-Path: <linux-kernel+bounces-138602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2F89F446
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524D9282088
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC315ECDF;
	Wed, 10 Apr 2024 13:28:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAF15ADA2;
	Wed, 10 Apr 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755733; cv=none; b=MaPK4UXADoF4xwzPeVsPPRK3mO/RMPjw1eh/hbZykdFgYGq13OdiovF3aTCB2ay/DOZUn9wJXTt7K+tGJWDsOCI61CA/clo71jIS513QEuQzJyrJC2tVk1PS17tU/DcysMtOtR/1OGkVy4pKggWpbD50lvpzSMMTf6D6vYWufKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755733; c=relaxed/simple;
	bh=50/9i2W7iSqDXVAobdGAJmhstPOEw6Q5CSVcHwfSkf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2YwhLhocU43fzvx03qLaolRWk9K9Z9DqyryyL4S9g0TMkwyQCPB7qvSJ496EQMJoXLmQkkawQa1UgXMllvOYDoFqXWO/ZzE+6KiarghC6neqnBFgO41YqWrohDmNMtgIyR3XqjAp4mA1v7EMM00hygjiap3VEsxZym7Z6IycFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45753C433F1;
	Wed, 10 Apr 2024 13:28:51 +0000 (UTC)
Date: Wed, 10 Apr 2024 09:31:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Atul Pant <quic_atulpant@quicinc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 rafael@kernel.org, daniel.lezcano@linaro.org, kernel@quicinc.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
Message-ID: <20240410093127.29e81d9f@gandalf.local.home>
In-Reply-To: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 10:24:15 +0530
Atul Pant <quic_atulpant@quicinc.com> wrote:

> We are trying to implement a solution for thermal mitigation by using
> idle injection on CPUs.  However we face some limitations with the
> current idle-inject framework. As per our need, we want to start
> injecting idle cycles on a cpu for indefinite time (until the
> temperature/power of the CPU falls below a threshold). This will allow
> to keep the hot CPUs in the sleep state until we see improvement in
> temperature/power. If we set idle duration to a large value or have an
> idle-injection ratio of 100%,  then the idle-inject RT thread suffers
> from RT throttling. This results in the CPU exiting from the sleep state
> and consume some power.
> 
> To solve this limitation, we propose a solution to disable RT-throttling
> whenever idle-inject threads run. We achieve this by not accounting the
> runtime for the idle-inject threads.

I'm going to assume that when dl-server is finally accepted, this will no
longer be an issue for you?

  https://lore.kernel.org/all/cover.1699095159.git.bristot@kernel.org/

-- Steve


