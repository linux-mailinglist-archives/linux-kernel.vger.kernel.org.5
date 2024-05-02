Return-Path: <linux-kernel+bounces-165871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA97D8B92B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AB61F21CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E47329A0;
	Thu,  2 May 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="NhiCBDJp"
Received: from ma-mailsvcp-mx-lapp02.apple.com (ma-mailsvcp-mx-lapp02.apple.com [17.32.222.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D04632
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 00:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609010; cv=none; b=eb1TL/4L2KDrRZQ1My/T1xgVsOKbF6+sfdVyiaqa/otiicaBVwFvJjCoO4gVi2jM2Ok26sPaEjBDfQyJ2Y59lKmzvgIq18Zmqy03gICRKzvg6UBkULvr0C0BZuLzs4NLR8+FQBtrbJmhQectXT4dlgOB1bX9eKGrEpAMcAlB0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609010; c=relaxed/simple;
	bh=FttjLP2RMELHyklUWIQJDa+KTsHTslmnMvr+Q/filAg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=mbSh+5adhyPezQARNrOKWUtq4vWfkZtpTHPmpoftPuxG8IKlBjJdPTULQSsspkncTE3Oxzb7vJ8NBK1qa3XhY/PI86Y+kirpaOppethhdB3bjq9XqYXkvJrPKRPuvDzlgxIcaRCl6J+3QBkxpHZUxyzYczgvn/g/Fz0uopMcnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=NhiCBDJp; arc=none smtp.client-ip=17.32.222.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SCU00YM70RLZ000@ma-mailsvcp-mx-lapp02.apple.com> for
 linux-kernel@vger.kernel.org; Wed, 01 May 2024 17:16:48 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=20180706;
 bh=NkY47ufs8kucjQXAyO31Twlr+ZWbr4oDpHiSLaMsAnU=;
 b=NhiCBDJpC/oMt1AxUm6xa80yXZvaGfnxeIIrSCMUW5aWGtAD0dWHMwmnbBazZh1NjW4Q
 NEOhtyeoJtRFlH3UKdpAPCPtfyBkZEYfB6nnCtCeZwfHU9Qe4sVFg261uvgku4yQPVpr
 0bQw8Rc9bFZen52eT6uRnglxcDM+WPPWrtNIaDIxqxwsBqTQ5uc8yvNIeyulqHXsuZle
 MdkYjzCFseEoGBrjiy1ySZghDFYFvKriquLSxRdeVtcW2FSgWGS1HbqJZz93jBF/ZnnZ
 0RuIuRAlV7eoDyR71dAZCW8EeX8NJV7bA/B6Jo6qDXTZFkQhIuzxYCZUCWCqv9035sOg JQ==
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SCU00KQ60RVUM00@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Wed, 01 May 2024 17:16:43 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SCU00N000GSQI00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 01 May 2024 17:16:43 -0700 (PDT)
X-Va-A:
X-Va-T-CD: cbf7380921e8e2f9db5ea993b70cea12
X-Va-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-Va-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-Va-ID: 0f36f4da-c23d-4baa-a49e-f113311040b5
X-Va-CD: 0
X-V-A:
X-V-T-CD: cbf7380921e8e2f9db5ea993b70cea12
X-V-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-V-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-V-ID: c8542c07-c203-4592-b250-b9207167abc0
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
Received: from mr41p01nt-relayp01.apple.com ([100.64.99.124])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SCU003GI0RTJA00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 01 May 2024 17:16:42 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Zayd Qumsieh <zayd_qumsieh@apple.com>,
 Justin Lu <ih_justin@apple.com>, Ryan Houdek <Houdek.Ryan@fex-emu.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Date: Wed, 01 May 2024 17:16:32 -0700
Message-id: <20240502001632.41289-1-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-reply-to: <20240411132853.GA26481@willie-the-truck>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

On Thu, 11 Apr 2024 14:28:54 +0100,
Will Deacon <will@kernel.org> wrote:
> P.S. I briefly pondered the idea of the kernel toggling the bit in the
> ELF loader when e.g. it sees an x86 machine type but I suspect that
> doesn't really help with existing emulators and you'd still need a way
> to tell the emulator whether or not it was enabled.

This seems promising to me. What do people think of adding an opt-in argument,
option, or similar to binfmt that allows users to mark certain file formats as
"must run under TSO"? And then, the kernel would set the TSO bit when invoking
the interpreter for those file formats. If an emulator decides to create a
non-CPU-emulation thread, then it can use a prctl to disable TSO and switch to
the default ARM memory model. Note that this prctl wouldn't be allowed to
enable TSO - it would only disable it. This way, it is much harder for a
faulty application to be made that relies on TSO, since enabling of TSO is
only done via a binfmt handler that the user must explicitly opt into.

It is true that existing emulators wouldn't be able to benefit from this, but
that's the case no matter the activation mechanism. We can, however, expose a
prctl to get the memory model, so emulators can detect if TSO was enabled for
their threads.

To summarize, I propose two prctls (similar to the ones in the current revision
of the patch series). One to switch from the TSO memory model to the default
ARM one (this is a one-way street). And another to query the current memory
model.

Thanks,
Zayd

P.S. I forgot to CC you in my most recent email to Marc Zyngier just now. 
Sorry, I'm quite new to using mailing lists.

