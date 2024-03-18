Return-Path: <linux-kernel+bounces-106093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F7187E8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AB828248A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389AF376EE;
	Mon, 18 Mar 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="bFMdFscK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7C364A4;
	Mon, 18 Mar 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762737; cv=none; b=L6xpNVDIwsr6qwVhVv3QogGz1Orc0ZWpNb3gp/uHS83+LnQgLhVWfceyPrlOmo0Q/pSHiVzEGBejqNSZ+o5qXB+3J6ZuS5z9PC+tsaBZm6PEJ9ZLtaB4G5Q5CWXN4PfzMxxCPDiCZH1dgE3acBm3ysAVIbImKMECNZZfZC2vTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762737; c=relaxed/simple;
	bh=rlUs+ow1J5r5sK/Kalk62nbARIdEYkTcwPmaengX5Vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9TOU+fVInBC2Fo0nl/TcBoOQn7KGLkA9RpPK2bDb73Od/5ajDJyGqdGx6x6SOT16Oav6rs4gqGCnGRRyw8qVeFeQdptgzXHYWFq60yWzVl1AgVdqe6kWZDkzva0Pjzb9ququN6hgwrtGj+zJLbwpr2IQC+S47EtochPFQpa0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=bFMdFscK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710762733;
	bh=i9CRW+oTEXP2RX7aLfZKKATP+J/BIcxQbk4aW/9GfOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bFMdFscKQ2QCxC92JgF/Zg79/cxyFcsfp24B6DrhnTNMFC2/Tzo+bMwUBVJVjhY+7
	 Olbnp1jZOS0zZ1U7lUC8/IBUt8lF/oxBCs/WrHKFDLJeLq3RIOz7/SYPTJnhZzglW5
	 RW4mAtNvgvH5JvsSPiKHq/LmYZUom4GwxUegdAVtV+Isaorp9yHWrU9mmpuyGkEiMK
	 LTx/LUSyWEA/Z/3+bvoLsTKUFwIIdeTI+XzFZk0MBxqKnLwHVXTmTqxXNRUw+GKZ7t
	 cLTl7W/72ATt7xOU+tj4BCpOH9sHCvaSyaUHCJw+0FNlSNt196JdqEX/g94NnEgK/u
	 LNGIlswB0H5WA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TytWK0ZL0z4wcF;
	Mon, 18 Mar 2024 22:52:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Stephen Rothwell
 <sfr@canb.auug.org.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Andrew
 Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the mm-stable
 tree
In-Reply-To: <61110d70-7b18-40a2-b3d2-6c267ab18096@csgroup.eu>
References: <20240229101721.58569685@canb.auug.org.au>
 <87ttlrg4hm.fsf@mail.lhotse>
 <61110d70-7b18-40a2-b3d2-6c267ab18096@csgroup.eu>
Date: Mon, 18 Mar 2024 22:52:12 +1100
Message-ID: <87o7bbzrir.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 29/02/2024 =C3=A0 07:37, Michael Ellerman a =C3=A9crit=C2=A0:
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>> Hi all,
>>>
>>> Today's linux-next merge of the powerpc tree got a conflict in:
>>>
>>>    arch/powerpc/mm/pgtable_32.c
>>>
>>> between commit:
>>>
>>>    a5e8131a0329 ("arm64, powerpc, riscv, s390, x86: ptdump: refactor CO=
NFIG_DEBUG_WX")
>>>
>>> from the mm-stable tree and commit:
>>>
>>>    8f17bd2f4196 ("powerpc: Handle error in mark_rodata_ro() and mark_in=
itmem_nx()")
>>>
>>> from the powerpc tree.
>>=20
>> Thanks. That's a fairly ugly conflict.
>>=20
>> Maybe I'll drop that patch until the generic change has gone in.
>>=20
>
> The change is now in linus tree.

Thanks. I have moved my next up and applied your v2 on top of the
upstream changes.

cheers

