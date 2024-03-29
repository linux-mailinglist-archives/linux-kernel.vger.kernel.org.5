Return-Path: <linux-kernel+bounces-124444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6025B8917E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCAC1F22D68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCC26A34B;
	Fri, 29 Mar 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="15ofR0A7"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F991096F;
	Fri, 29 Mar 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712066; cv=none; b=JZhpcIZbtEusdP6RS2+Wm/DL+P3LJ2qPYMN5wxOsHjBiT4NQv4ToumXKAgk12gPCqJRPlf5wTurtbBlf48OY9VfYeCjYTW9DvZefwS263T0E7fgoSV9jtFwmt99OyGxF5WXSMZIwvlKh8DbUYhxuaKs8gU0XjOWDv6O4ciZayNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712066; c=relaxed/simple;
	bh=CD+U/4SMvslHllsXoojsThdlHsrwenDb0wNTOqeQPjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W0xtjAeyrMPSP1oLtahu1aNjqTv8BgmRpdr8gzgJKdJVkzYdUf6YaZLExX9ySN9plNc5p6xm/Wc/QHinJowe49B9U0umYfK3krZIEhhNhyy/bg5vKS4H1AEbgjxDCCd9IB9MQTXLymN2rTljxQLoSplHV0wPi/Nbbb0HBQXC87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=15ofR0A7; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1711711998; x=1712316798; i=kernel@valentinobst.de;
	bh=kiemghf0V/GSK2wbZLm1KTLUSSgc/ODkFkc449G7fSI=;
	h=X-UI-Sender-Class:From:Date:Subject:To:Cc;
	b=15ofR0A76otzeI/sIVKoaC8Qv2gy7vxHim2Ymh1CY7FWbG+DWtRahTZw6V+CoZPM
	 sgAAJccwjr3jXRsVI72swtSHjdLD09Tjckr8f+c0IIbGHTfEzvdwb9FR9i9FnCwPW
	 hF/zg05P8SMCIJcE6ViA7FOT+OrS6vG9Lg2z+0HKgbwtSYJnmKygP6q19B5wVfXnb
	 q84NlE/zJCPZi96h/eQ9glpGb9Zq8qvfaSY41uATCybsQ+wLUCiXETdqJE2Z/EM5U
	 sg34+2aXk+z4G2rl6bwQQFzVYQz3JTfosFWQEawD+gr5U/gKUWC8mgSuLblGdHdQ/
	 bqQYw+6lVQhP1ZJ58w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.77.77.61] ([217.249.70.154]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N4hex-1soHPN2Wxj-011hm9; Fri, 29 Mar 2024 12:33:18 +0100
From: Valentin Obst <kernel@valentinobst.de>
Date: Fri, 29 Mar 2024 12:31:58 +0100
Subject: [PATCH v3] x86/tools: fix line number reported for malformed lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240329-x86-insn-decoder-line-fix-v3-1-ec97e21d63bf@valentinobst.de>
X-B4-Tracking: v=1; b=H4sIAK2mBmYC/43NQQqDMBAF0KtI1p1iRmtsV71H6UKTSR2QpCQSL
 OLdG10VCqXL/5n/ZhGRAlMUl2IRgRJH9i6H6lAIPXTuQcAmZ4El1iWihLltgF10YEh7QwFGdgS
 WZ1C9tEhSVWityPtnoFzv9u2e88Bx8uG1v0pya/9RkwQJtdLm1EklW91cUzeSm9j5Pk5HQ2KzE
 3561S8Ps6cN1WfdnG2+/vbWdX0DnP7P+xgBAAA=
To: Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Baublitz <john.m.baublitz@gmail.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
 linux-kernel@vger.kernel.org, x86@kernel.org, stable@vger.kernel.org, 
 Valentin Obst <kernel@valentinobst.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711711993; l=3102;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=2yrFMY5+SkggOHssX479kJtPf1H7LqZLVDyny3osaw8=;
 b=/Nn//02Z2oCL5gr446bWK3XQ8O4GS/oo2j5cCI9ik9RCoNR8lTuw66hxInDLN48SptcHnrqzR
 Ky+lvc0vuIMBIAeR3hJ98InwVMWPPLtnydzMN19YC4Qx44LQeWOnzxC
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Provags-ID: V03:K1:Dw8Wc4f3SmNQdchz8rSOTpOoyWdA1Zrbv/NisIdmEkpeigaiwaZ
 Hntcz/jWJi56Mt3VO+ElFiDob1y0ULkKfnQwo4E3eC0dSngn9kpi4jVawtOVjfba4oYCrKl
 VPzTgVmtZJ4lW8/ROZAUuWT41HSQIdxj0OQck8BzXEEPdAgsfMDMUeSxlAr0O9FaTR3n5VU
 1b+BMQHsFnyHNSJNg/m7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7io/rqjPaZQ=;olFbZPdz3zE1etpUCGrzuB58KL8
 PLVp5bABWX65KousaqgreXUxCV5GtNsM+SdTI+kA9goxjenIa2HOpFHFpc6EcEPmixJxTmvkY
 Q7wZpGT6osuw0ChUvNN6lhL81oTeN/i2vJNGAozFIFGLXMbMihzunjSwLqcjQxb63eKXOdXKU
 mkLxbvM+qFl7BArjIMl/j6qSjuzWv1roybzEZUinMU5xCqXIZVFwk60eOvtfN5NGg1xIsRvmy
 SpuGPgRlvveUoQ3gHPwrVirEFzC78yezhr/0plSY9mglqM3NcsSZ2pUynIGAkfXOzLEXNSEjm
 1VfuRNIUgO+dAiWjNiuMrQylEmtJ0DWPE7ziosRkRESLNVnAfIH+dqMiOhHucKpcMc/FLgZ6i
 mrwQdQaxUksrhmscHAd4TjtQqJQ2GquVey9qvemPH04q6iicbZLGxYE1hImxZpyiTZCW2XdlZ
 ygHHgralNdARXxJLspGMlQ3vNpoHt3gEDOsIKBniuzjKbS90shQQp3wAPoD0pvItsCTHd884j
 uoDl0l4qoMD6hNcOJGTmouKcZnPjVjJNFZMUCr1dyHIzJDq519buQ68Xoc1kQT0pAC+HrXike
 eRo+xLmN3fecC9r9h+9yAminvFu95nt2dWhDEZLpOK/NSon0Fxel1YQdemvltl4AbrmldRRO2
 QKn0pjdELTMcElLvpg1qhgC+9NUd5K4kienmuvyz1h5NVxaF0NHp2eUcCr1eM7iJ0qAkBmFT5
 unIXxEkwQ9bpECDIakWz35cN523+Qjosb+4RoX64A+tPbdPf//CdRI=

Commit 35039eb6b199 ("x86: Show symbol name if insn decoder test failed")
included symbol lines in the post-processed objdump output consumed by
the insn decoder test. This broke the `instuction lines =3D=3D total lines=
`
property that `insn_decoder_test.c` relied upon to print the offending
line's number in error messages. This has the consequence that the line
number reported on a test failure is unreated to, and much smaller than,
the line that actually caused the problem.

Add a new variable that counts the combined (insn+symbol) line count and
report this in the error message.

Fixes: 35039eb6b199 ("x86: Show symbol name if insn decoder test failed")
Cc: stable@vger.kernel.org
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reported-by: John Baublitz <john.m.baublitz@gmail.com>
Debugged-by: John Baublitz <john.m.baublitz@gmail.com>
Signed-off-by: Valentin Obst <kernel@valentinobst.de>
=2D--
See v2's commit message and [1] for context why this bug made debugging a
test failure harder than necessary.

[1]: https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Help/topic=
/insn_decoder_test.20failure/near/421075039

Changes in v3:
- Add Cc stable tag in sign-off area.
- Make commit message less verbose.
- Link to v2: https://lore.kernel.org/r/20240223-x86-insn-decoder-line-fix=
-v2-1-cde49c69f402@valentinobst.de

Changes in v2:
- Added tags 'Reviewed-by', 'Tested-by', 'Reported-by', 'Debugged-by',
  'Link', and 'Fixes'.
- Explain why this patch fixes the commit mentioned in the 'Fixes' tag.
- CCed the stable list and sent to all x86 maintainers.
- Link to v1: https://lore.kernel.org/r/20240221-x86-insn-decoder-line-fix=
-v1-1-47cd5a1718c6@valentinobst.de
=2D--
 arch/x86/tools/insn_decoder_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_deco=
der_test.c
index 472540aeabc2..727017a3c3c7 100644
=2D-- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -114,6 +114,7 @@ int main(int argc, char **argv)
 	unsigned char insn_buff[16];
 	struct insn insn;
 	int insns =3D 0;
+	int lines =3D 0;
 	int warnings =3D 0;

 	parse_args(argc, argv);
@@ -123,6 +124,8 @@ int main(int argc, char **argv)
 		int nb =3D 0, ret;
 		unsigned int b;

+		lines++;
+
 		if (line[0] =3D=3D '<') {
 			/* Symbol line */
 			strcpy(sym, line);
@@ -134,12 +137,12 @@ int main(int argc, char **argv)
 		strcpy(copy, line);
 		tab1 =3D strchr(copy, '\t');
 		if (!tab1)
-			malformed_line(line, insns);
+			malformed_line(line, lines);
 		s =3D tab1 + 1;
 		s +=3D strspn(s, " ");
 		tab2 =3D strchr(s, '\t');
 		if (!tab2)
-			malformed_line(line, insns);
+			malformed_line(line, lines);
 		*tab2 =3D '\0';	/* Characters beyond tab2 aren't examined */
 		while (s < tab2) {
 			if (sscanf(s, "%x", &b) =3D=3D 1) {

=2D--
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240221-x86-insn-decoder-line-fix-7b1f2e1732ff

Best regards,
=2D-
Valentin Obst <kernel@valentinobst.de>


