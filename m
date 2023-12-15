Return-Path: <linux-kernel+bounces-653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 658AF814419
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605AEB22880
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C8818B04;
	Fri, 15 Dec 2023 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvhpFINa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35518AF0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B06C433C8;
	Fri, 15 Dec 2023 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702630929;
	bh=GxjorUvjVfFdNsGcr47vxy9wVmeBkGFklppC39F4NSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WvhpFINabgM+XrOxUOlTLD7JyTXZTYt5+i6n4Cj4VpJYYN1VMPzELtKouqYtG7ZNh
	 +Cj+Jem2vI8v7Iaiz5xwtT3mAjL1oEg2fpbF41FukjzyKR5p6x77tVYShNS7LMFXMH
	 kxKAuf5YQPcpHKjYstLIfOhe7pGH3EjUxS24/u7wLDwDJxuskG12ugHgYqw1sge2qE
	 LySRkfD51BOthJ5zdAgjLdKEM01qVO/1JMSJuzTM1IJBCgmfZrvUg1Jl949eSTGag+
	 XLV6e88ig6U6QMzDuBEptw2qGt/JQBu4RylOHM7/GCw4oR+zznkmfbTD/L5liaHXNA
	 e7JVS+Bijp1uQ==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>, glider@google.com,
	elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: Re: [PATCH 09/13] powerpc: Disable KMSAN checks on functions which
 walk the stack
In-Reply-To: <20231214055539.9420-10-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
 <20231214055539.9420-10-nicholas@linux.ibm.com>
Date: Fri, 15 Dec 2023 14:32:02 +0530
Message-ID: <87wmtfu9dh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicholas Miehlbradt <nicholas@linux.ibm.com> writes:

> Functions which walk the stack read parts of the stack which cannot be
> instrumented by KMSAN e.g. the backchain. Disable KMSAN sanitization of
> these functions to prevent false positives.
>

Is the annotation needed to avoid uninitialized access check when
reading parts of the stack? Can you provide a false positive example for
the commit message?

-aneesh

