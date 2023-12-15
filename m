Return-Path: <linux-kernel+bounces-435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F97C81411A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6378B21FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B140D610D;
	Fri, 15 Dec 2023 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFmXIMrX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0FA53A5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7AAC433C8;
	Fri, 15 Dec 2023 05:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702616495;
	bh=8RH/h1jakl0y7fPQ+kWUq85u6w9KslnUix/YJd0gqak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uFmXIMrXVkH0fn/PsKKyhCuvCCKR72ILItsqoCmKdvQicjHJTk+itW07h9q+uxgTx
	 4S5Xy9zdMEROVAJXk2UlqHVCvs6I5971BZncNlgXD1hKoPgutrEHHlds3gysgQDnrX
	 Ck3Z3aTsBWHh+UutJIO8B+GRu5Mn3FprvP/T20ycwjRfUjtOtmDguHYNFZIqK+7G9c
	 61CedmmpQ9Do9oyZ2KJa2OG2XfyFt0vydvqaKpbMQs0oCFPDRXJ+CkS1Cl0T57D0/N
	 R1XkIMdk+2ODC2zza+9UphvjUoBwYb1TzVDIQ2ksM2kYQDZkEfUZ8Nu/pPblV1piWq
	 7RLuZxlrNt0dg==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rohan McLure <rmclure@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v5 1/5] powerpc/smp: Enable Asym packing for cores on
 shared processor
In-Reply-To: <20231214180720.310852-2-srikar@linux.vnet.ibm.com>
References: <20231214180720.310852-1-srikar@linux.vnet.ibm.com>
 <20231214180720.310852-2-srikar@linux.vnet.ibm.com>
Date: Fri, 15 Dec 2023 10:31:26 +0530
Message-ID: <87zfyct5y1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> If there are shared processor LPARs, underlying Hypervisor can have more
> virtual cores to handle than actual physical cores.
>
> Starting with Power 9, a big core (aka SMT8 core) has 2 nearly
> independent thread groups. On a shared processors LPARs, it helps to
> pack threads to lesser number of cores so that the overall system
> performance and utilization improves. PowerVM schedules at a big core
> level. Hence packing to fewer cores helps.
>

....

> +/*
> + * On shared processor LPARs scheduled on a big core (which has two or more
> + * independent thread groups per core), prefer lower numbered CPUs, so
> + * that workload consolidates to lesser number of cores.
> + */
> +static __ro_after_init DEFINE_STATIC_KEY_FALSE(splpar_asym_pack);


DEFINE_STATIC_KEY_FALSE_RO ?

> +
>  /*
>   * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
>   * This topology makes it *much* cheaper to migrate tasks between adjacent cores
> @@ -1011,9 +1018,20 @@ static int powerpc_smt_flags(void)
>   */

-aneesh

