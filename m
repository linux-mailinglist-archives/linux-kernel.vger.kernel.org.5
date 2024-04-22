Return-Path: <linux-kernel+bounces-152949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF98AC680
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95251F216C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94C4F605;
	Mon, 22 Apr 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M62Y1IbU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312FC45BEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773757; cv=none; b=e34cSAkRE8Gv98M+isLJ44H6CuKJ0gLHwbuOe4lUizU+B3fPGPC1W1foODKz2ewl87Yd3pKNcTQb2tyA4BRc6ISsD8SJoc+ZNYBPdMlPtHeycSoewH56CcDfXjzZe++HQKsrY19NREnWU5dEAMs79Nqfk8CKlgB95o2Bc3wHCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773757; c=relaxed/simple;
	bh=vk02iZBNmKdC61r3MWBFt9WwwCHm+5e2jYj0mZexwz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQuu44XPvyHpmNtLz6nr6P/+5xFy1KvDnVHYK+4+tvCmRVtmWxexCb4faxz6EpvKB8MK6k1mNWDEcYusdVG493pqWe3Hpkd2mRiJaTin1TWwbvoODRQxv0TosZrHn5g+giMgb+RZQ2JrcLeyWd6nfE24VpKRXxBI8rlqrjFc/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M62Y1IbU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713773755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n7pj1YX0zvZoJ4fszFdVU7DclyCmRGFDahad/XyHzlU=;
	b=M62Y1IbUIJcJTlCstGU3ao/cKPu+FJqAB9Ouclo25cKJe3Cj/+Nmw3JQj9bAGZTl7INmvD
	4YNqbKmp4Yf7ZkNx9qeq6oNbthCHzg61G4Zn4LFJRaMHLrsAM/Xat94syqxkCKIdhJ14Um
	lgr4uMGDpnrYcmRpjuS28eDOozG28Lw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-J11HdeYyNCS4_-jfjacDCA-1; Mon,
 22 Apr 2024 04:15:50 -0400
X-MC-Unique: J11HdeYyNCS4_-jfjacDCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34D1B29AA2CD;
	Mon, 22 Apr 2024 08:15:49 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.39.194.90])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD1AA43FAD;
	Mon, 22 Apr 2024 08:15:45 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-toolchains@vger.kernel.org>,
  <mpe@ellerman.id.au>,  <npiggin@gmail.com>,
  <christophe.leroy@csgroup.eu>,  <aneesh.kumar@kernel.org>,
  <naveen.n.rao@linux.ibm.com>,  <ebiederm@xmission.com>,
  <keescook@chromium.org>,  <x86@kernel.org>,
  <linuxppc-dev@lists.ozlabs.org>,  <linux-mm@kvack.org>,
  <bpetkov@amd.com>,  <jinisusan.george@amd.com>,  <matz@suse.de>,
  <binutils@sourceware.org>,  <jhb@FreeBSD.org>,
  <felix.willgerodt@intel.com>
Subject: Re: [PATCH 1/1] Replace macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
In-Reply-To: <20240412062138.1132841-2-vigbalas@amd.com> (Vignesh
	Balasubramanian's message of "Fri, 12 Apr 2024 11:51:39 +0530")
References: <20240412062138.1132841-1-vigbalas@amd.com>
	<20240412062138.1132841-2-vigbalas@amd.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 22 Apr 2024 10:15:44 +0200
Message-ID: <874jbt7qz3.fsf@oldenburg3.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

* Vignesh Balasubramanian:

> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index c9a46c4e183b..5c402788da19 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -65,7 +65,7 @@ extern Elf64_Dyn _DYNAMIC [];
>  struct file;
>  struct coredump_params;
>  
> -#ifndef ARCH_HAVE_EXTRA_ELF_NOTES
> +#ifndef CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES

You could add

  #pragma GCC poison ARCH_HAVE_EXTRA_ELF_NOTES

to a central header, to let GCC and Clang flag uses that have not been
converted.

Thanks,
Florian


