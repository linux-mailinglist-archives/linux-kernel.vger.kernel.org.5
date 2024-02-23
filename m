Return-Path: <linux-kernel+bounces-78367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1986128A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A691F244B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328627E786;
	Fri, 23 Feb 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="YP916j38"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947997EF0A;
	Fri, 23 Feb 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694280; cv=none; b=pVc7VAQ00iKZ5ivS7BT4YvOCP3aKf1prDXKipntQD49Dwodvvc6yFarsNmJSJEWfpLMfExFxJVxIlSJmwASkaPf0cUKLQ0LMApttLYwjfuIkhUufj34A8W46lKC98l1nDXpIO94PzOd9bPGbrcQs3b0Dc+N0JTkrSEJlkayU/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694280; c=relaxed/simple;
	bh=2JY+3DjG6lK45y3gH2HcJ0xwn7fJU24FgxnMJ0ij53U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kNyymquj5H739AkYBobzCOKaYNP/u6t9edZpcZtP/+wF9mCtmEcbX3/jWLcdaZuR7IgefUHxhgfPTUPqaI7XJqihY6PxJvBQ5JWIXyNsqQsPQXlANw3qV0GIQxjvjlIxFnKn5dvMx+qq/VGh7ijNbFwfnJKB9LIxNAaObCc/LvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=YP916j38; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1708694262; x=1709299062; i=kernel@valentinobst.de;
	bh=2JY+3DjG6lK45y3gH2HcJ0xwn7fJU24FgxnMJ0ij53U=;
	h=X-UI-Sender-Class:From:Date:Subject:To:Cc;
	b=YP916j382Om/wJDpeMVdPKBp4Rq2vdl1ggRz6j7ycQC09X1AUejyZV16GPL2ZGuA
	 AdZ32MlIlampf/ejsFeqx4SKY+ly0BQbHq2VFR3miRHX0pN5O30o+BriwCKrPMBpz
	 RVnM8amUiQ0poElLXTvIiNhy6sqDqgOF9dnELQRUaV2weqylbF0ow9vigEiLwgmDW
	 T49+6Fi4KGIykidzw1M876t1sN+a2EvRW6OIBdyiOobb3/DMKUmG0OrYvD2GtIqww
	 1xTBLUBLVv+9eKchqulOq6Wuut4I8lJAauzq4K4zg89E0qU8rhTGGGe/wGtarNKxR
	 yNy9aMVni1jchYY7Xw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.101] ([95.223.130.98]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MPoTl-1rINoF3RnX-00MxPZ; Fri, 23 Feb 2024 14:11:16 +0100
From: Valentin Obst <kernel@valentinobst.de>
Date: Fri, 23 Feb 2024 14:10:51 +0100
Subject: [PATCH v2] x86/tools: fix line number reported for malformed lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240223-x86-insn-decoder-line-fix-v2-1-cde49c69f402@valentinobst.de>
X-B4-Tracking: v=1; b=H4sIAFuZ2GUC/42NQQqDMBBFryKz7hQntUa68h7FhSaTOiBJSSRYx
 Ls39QRdvgf//R0SR+EEj2qHyFmSBF9AXSow8+hfjGILg6pVUytFuHUtik8eLZtgOeIintHJhno
 ip5j0TTkHZf+OXPTZfg6FZ0lriJ/zKtPP/lPNhISNNvY+kqbOtH0eF/ar+DCl9WoZhuM4vmBqy
 QPIAAAA
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org, 
 Valentin Obst <kernel@valentinobst.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708693872; l=4956;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=lbnH0WF4tXXmXq+akd4bXjRC9W7lA7jDYNQ6lPoUNDw=;
 b=NKIy1z/7P/uMN+m5mHRZ2o1/ocPXjhkEHpMT7bwPTFoeIFmDbMfeX56ekFvHSgFq8kUT2CqRe
 C4uJFGW/uf8AeViKowR0NrHbnwEfvbPXJ1QiUVH7LHUt2sT/Jk2NJwQ
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Provags-ID: V03:K1:6q3lfldMp4TifScdm6dJFNHXLxeAsJf8YBsSiHxjwVeiMrZEaRm
 /xF6rtmRuxT1ihSpcMORxe697KN0vNHT+cXWyJ+Z8K8WPCKn2fj8eQV1w8T63WjotYBW7TK
 V7LjICeh4A1yjQQE1EcXAEm0bgRRFmV2fiNTkVMBpZuMJQiZ8PDvstu/d4GzkYWJ/r970nf
 xTDOCYu8hpW/3H4LmSHLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3xLKqbCpHv8=;NNUjALKrxqZfucfBVKNpSHyNDSP
 dPTUbjGItOeu9HJx/qbn6lVnKyQ9zXp8EqApO3it98ZhiBd4GSsHr6RiznARqg2KedR6QXgEo
 p7YBBnhbXHybXxv3s4TgZY1NGKoXZS0Nhw6tzHObiYE+h2PivPwHV7PZ1T3xMLUTntQTKlaWj
 RVXoaRgMkIwbqwwDuGTT1z+J2bRsgMuizgduVooHsfILkPE0Gvk2PLQs2HBkFcOdbWifKda2S
 ApH1Et2YPGBmB+QedmY6dJ5JRP13/md4BZZ5KxthPAG1MH6f0iNOFi/Dg+9blUr/edzhzAHwq
 MbP/YuWXXhG9KWCgSwkMVZgkAsTBqDHfl8YU/eT2KgGWZT65W0lznpi4z8zPOGOxt7UNFLUvW
 y9sXim8BrCNm3FDprjv7SYI5Ib4Ia9EpOq8LflYgzuChANDJav6TsCieitm+hMBsZNGC89cId
 m48CyoaowJ5nMxoDHVrpRy0xjwUD+61ZTxSVg5iTUYEYKUwN3RvznDpPCrUf8S76hhqaNYlBt
 P7BPMzy+nS+n0/OTcCc5tKW+cks14Qu52DFNCEn1Xs7yR2Akwyo0xfierH0NTPDHMC2M0U3qu
 6dej5GbJ58PAD8B/TWfrHUq6Mj1T5QK7C5RDIofuPn3nQemMYyFEI1T3coA9Ye1UXZevM05UA
 WmmYC06RaO1OmKnJch1DnF4nk9qq+dysMqMhP1HnUc95fsu1cBtP9Frx+SJZxrYpwkrGyhm/P
 BTB5CDhiE8leou4PM0NmjALHxKQZ+KRiEo6N/TWYRI/pAKh4mNGfM4=

While debugging the `X86_DECODER_SELFTEST` failure first reported in [1],
we noticed that the line numbers reported by the `insn_decoder_test` tool
do not correspond to the line in the output of `objdump_reformat.awk` that
was causing the failure:

  # TEST    posttest
    llvm-objdump -d -j .text ./vmlinux | \
    awk -f ./arch/x86/tools/objdump_reformat.awk | \
    arch/x86/tools/insn_decoder_test -y -v
  arch/x86/tools/insn_decoder_test: error: malformed line 1657116:
  68db0

  $ llvm-objdump -d -j .text ./vmlinux | \
  awk -f ./arch/x86/tools/objdump_reformat.awk > objdump_reformat.txt
  $ head -n `echo 1657116+2 | bc` objdump_reformat.txt | tail -n 5
  ffffffff815430b1        41 8b 47 1c             movl
  ffffffff815430b5        89 c1                   movl
  ffffffff815430b7        81 c9 00 40 00 00       orl
  ffffffff815430bd        41 89 4e 18             movl
  ffffffff815430c1        a8 40                   testb

These lines are perfectly fine. The reason is that the line count reported
by the tool only includes instruction lines, i.e., it does not count symbo=
l
lines. This behavior was introduced in Commit 35039eb6b199 ("x86: Show
symbol name if insn decoder test failed"), which included symbol lines
in the output of the awk script. This broke the `instuction lines =3D=3D t=
otal
lines` property without accounting for it in `insn_decoder_test.c`.

Add a new variable to count the combined (insn+symbol) line count and
report this in the error message. With this patch, the line reported by th=
e
tool is the line causing the failure (long line wrapped at 75 chars):

  # TEST    posttest
    llvm-objdump -d -j .text ./vmlinux | \
    awk -f ./arch/x86/tools/objdump_reformat.awk | \
    arch/x86/tools/insn_decoder_test -y -v
  arch/x86/tools/insn_decoder_test: error: malformed line 1699686:
  68db0

  $ head -n ` echo 1699686+2 | bc` objdump_reformat.txt | tail -n 5
  ffffffff81568dac        c3                      retq
  <_RNvXsP_NtCs7qddEHlz8fK_4core3fmtRINtNtNtNtB7_4iter8adapters5chain5Chai=
n
  INtNtBA_7flatten7FlattenINtNtB7_6option8IntoIterNtNtB7_4char11EscapeDebu=
g
  EEINtB1a_7FlatMapNtNtNtB7_3str4iter5CharsB1T_NtB2D_23CharEscapeDebugCont=
i
  nueEENtB5_5Debug3fmtB7_>:ffffffff81568db0
  ffffffff81568dad        0f 1f 00                nopl
  ffffffff81568db0        f3 0f 1e fa             endbr64
  ffffffff81568db4        41 56                   pushq

[In this case the line causing the failure is interpreted as two lines by
the tool (due to its length, but this is fixed by [1, 2]), and the second
line is reported. Still the spatial closeness between the reported line an=
d
the line causing the failure would have made debugging a lot easier.]

Link: https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/ [1]
Link: https://lore.kernel.org/rust-for-linux/20231119180145.157455-1-sergi=
o.collado@gmail.com/ [2]
Fixes: 35039eb6b199 ("x86: Show symbol name if insn decoder test failed")
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reported-by: John Baublitz <john.m.baublitz@gmail.com>
Debugged-by: John Baublitz <john.m.baublitz@gmail.com>
Signed-off-by: Valentin Obst <kernel@valentinobst.de>
=2D--
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
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240221-x86-insn-decoder-line-fix-7b1f2e1732ff

Best regards,
=2D-
Valentin Obst <kernel@valentinobst.de>


