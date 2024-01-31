Return-Path: <linux-kernel+bounces-47096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F63844910
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BFD1C2308B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F9A3839F;
	Wed, 31 Jan 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ARBz+MSp"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52B20DE0;
	Wed, 31 Jan 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733741; cv=none; b=E6w6elcYy/RIG2g0PX2QhBGV4J6cQCptEBTX2t4HHbM7v677IPOLQrWhPo7O/RJ8yJmkfppQZTJO2IlTITrhEVG/IT9pVlJL4VgW8I50YQHCDcJuqcg8Xc2h6hPUE58aKW36aljjmas3bs/G1uyN0MnJe5jFOJgvqZRZN1AS+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733741; c=relaxed/simple;
	bh=iCd/z3ZhJiwbvZDbjGrTq6Xj86/HS7Uqec1TZyUbpnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uefJ+hFZ7236WwtgQsdsxOLuye9KrNSGtafFhyIVyLXI+fOQdXcvCiupo5XAHKX0+/tQqcAt3GJp2SOfNbufJ0PI5OjVuK5Sxo+5vKBCM/wC10c5MT4+oZEBR+VImqUfi6nvxzVZbtvFnNJTfBA7WTcP6mJs6W8OtYj+IyJPyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ARBz+MSp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706733735;
	bh=4rdtf4LuoZzh7J5jcGE4PvRQ08J1Kn0j1es+qeP3Of4=;
	h=Date:From:To:Cc:Subject:From;
	b=ARBz+MSp5QPT0RVndSxMgeU2dfJxNe60FDNIwoySbxY4Manme7xiSRRr481PblJOJ
	 mn5yrv91BlDfUNsWk9vQtvNBQOe5S4Ht1tBCcFsGsLgVkPtzgM3uI/uLAskcOuO8WC
	 /qOQUdT23ShdbnkG8AqDccZsxYJLminfZ1H/S5yOatd60sWC6jc3dCc7PgM7fhz0er
	 wwMgx1lMvXZSmf3XZNjTAlhivUd/2ugUXYcJYssT3gb6QEldbNB9V/B1MZJcM+BCeV
	 GWNPRSNoj5LSLnhjQOomtFzpOTm5CY4GY1Q1Klpb1KHAVwMiBvL707lDYEkioFHIks
	 uit9wDzCkU+aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQDVX75lPz4x1v;
	Thu,  1 Feb 2024 07:42:12 +1100 (AEDT)
Date: Thu, 1 Feb 2024 07:41:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20240201074102.00726258@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dktiJloPzo_9TMacUSWcm3n";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dktiJloPzo_9TMacUSWcm3n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  b564b0111a3f ("x86/fred: Invoke FRED initialization code to enable FRED")
  43ca697baecf ("x86/fred: Add FRED initialization functions")
  ae46f3978ae4 ("x86/syscall: Split IDT syscall setup code into idt_syscall=
_init()")
  cb5429aaa0c5 ("KVM: VMX: Call fred_entry_from_kvm() for IRQ/NMI handling")
  d8fbd0496286 ("x86/entry: Add fred_entry_from_kvm() for VMX to handle IRQ=
/NMI")
  8c968f4df73c ("x86/entry/calling: Allow PUSH_AND_CLEAR_REGS being used be=
yond actual entry code")
  ed63bc7d4953 ("x86/fred: Fixup fault on ERETU by jumping to fred_entrypoi=
nt_user")
  531ff17a705a ("x86/fred: Let ret_from_fork_asm() jmp to asm_fred_exit_use=
r when FRED is enabled")
  db7c787d8ba2 ("x86/traps: Add sysvec_install() to install a system interr=
upt handler")
  5dd56c94ca2f ("x86/fred: Add a machine check entry stub for FRED")
  3e91abaa5673 ("x86/fred: Add a NMI entry stub for FRED")
  4af12f6a393c ("x86/fred: Add a debug fault entry stub for FRED")
  2ad2917c6f50 ("x86/idtentry: Incorporate definitions/declarations of the =
FRED entries")
  9f6870bafc18 ("x86/fred: Make exc_page_fault() work for FRED")
  f102fe126d28 ("x86/fred: Allow single-step trap and NMI when starting a n=
ew task")
  d0fb796dc347 ("x86/fred: No ESPFIX needed when FRED is enabled")
  5710910a6c94 ("x86/fred: Disallow the swapgs instruction when FRED is ena=
bled")
  f393835cbab6 ("x86/fred: Update MSR_IA32_FRED_RSP0 during task switch")
  fcd06abf6de2 ("x86/fred: Reserve space for the FRED stack frame")
  c413db75cb7d ("x86/fred: Add a new header file for FRED definitions")
  c125443456e9 ("x86/ptrace: Add FRED additional information to the pt_regs=
 structure")
  ed262541af19 ("x86/ptrace: Cleanup the definition of the pt_regs structur=
e")
  0b2e6c1c724f ("x86/cpu: Add MSR numbers for FRED configuration")
  95d34efac1a0 ("x86/cpu: Add X86_CR4_FRED macro")
  379ae086a73c ("x86/objtool: Teach objtool about ERET[US]")
  567f7205dd7a ("x86/opcode: Add ERET[US] instructions to the x86 opcode ma=
p")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/dktiJloPzo_9TMacUSWcm3n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW6sH0ACgkQAVBC80lX
0GwOzwf/ZlD0dCYGex2yyQcDWd8K3JmimV7jZBIKLFZW1h7DLaCuqJoEQY1eOrzT
26eFaHFCM/Ied3NXdV08l/e2X+JcxOXNqIvzE4gG8b+JTwIX8BC6ydsRZQSY/S1O
Q4IHixG1n69+hIkHLO9vw1k/hUuxJdo0JZ32b+MNguXBi/i8ysrAqpH+N2Wm/eVE
r4C3EOA/4fp4LBr0jMlDP1uxIuPwEY6L8mRFFjI8aTErdPyEKK3f2PZZnh8EV+iM
fGYUP7Do9SzAvD79zB3bEoun8lkjD7quig+w2CB4hWiPkUG4SNYn9S4B+wAPZhsM
gHdPYH9IRZ76sVxgNwXH5CkTN2uT4w==
=g9ed
-----END PGP SIGNATURE-----

--Sig_/dktiJloPzo_9TMacUSWcm3n--

