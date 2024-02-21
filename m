Return-Path: <linux-kernel+bounces-74339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39C85D2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8B4B22CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03A3D0C0;
	Wed, 21 Feb 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="gEGdeNEd"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BF3CF72
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506042; cv=none; b=cC95Zji5n+jEnlWg6eHH2V8WDr5Yuwmz2FTfi3Ij+aTsEgDq1EGFrZbk50cP+5wHW8JGeecpxgDz7/M4df40hFGyg6a03Di0JlWsWY0/nNbbY3xkmvCN1jlc0cV3GKmsvItiU2XF68Zh6twOW7jsQ66dfdaA/pmJN0kRnZGi3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506042; c=relaxed/simple;
	bh=lOk/Sj21EXxCRmBe+YSmEWfqFcljKsQ0DRuxtfgqqT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s92lYTg1Pp11zczyhGDHzAFYayfA+VRZa8maWIUPtVI7e40N2n0vBHt/hIWg14SzPxBPnINEKw9LcFCPVtQydlrO+D+ssu+PCl6Iyn0QiXQvaLWikuRrYCwuMgVgW8aaKQ53q+BVtfxQNwyN+ZXcOgkiVWGbrIBnzLCtj+uP+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=gEGdeNEd; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1708506030; x=1709110830; i=kernel@valentinobst.de;
	bh=lOk/Sj21EXxCRmBe+YSmEWfqFcljKsQ0DRuxtfgqqT0=;
	h=X-UI-Sender-Class:From:Date:Subject:To:Cc;
	b=gEGdeNEdnMF8XKOrjBbVFcFz8tB7/dKO+hCk8n4MeBxU+pBTLNmEY4K75BA2tttk
	 gtbQMFJuPNoUzlnbUTXqEeYnbQ51B+K56zgrZQa3CaUeSPuCz3hxWmfUPsJ+EpjlW
	 zXK3MFjmybz74et4o6Snf3WkIuiZHBk3devfZ4lsT5Z7xmPBxOKnIusdPXX/iZYbX
	 pSRzc/Saa6jkAzYezvbJAPsIBFovozXdhSxjO2491Qmro0MFHD7p9DjJGp14StJ7I
	 wM8jorlnyecylKWKVmZP7n6pMeQnYo1RKgEwIomKiqsgcpcMA/2AeLln3Fy+eA7Xm
	 yGPi+0dzx8j0CB9m/g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.2.229] ([79.233.63.110]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1N6KQZ-1qs7DZ2vsH-016j74; Wed, 21 Feb 2024 09:54:04 +0100
From: Valentin Obst <kernel@valentinobst.de>
Date: Wed, 21 Feb 2024 09:53:37 +0100
Subject: [PATCH] x86/tools: fix line number reported for malformed lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240221-x86-insn-decoder-line-fix-v1-1-47cd5a1718c6@valentinobst.de>
X-B4-Tracking: v=1; b=H4sIABC61WUC/x2MwQqDMBAFf0X27EKyFlP6K+JBzYtdKKskIIL47
 4YeZ2DmooKsKPRpLso4tOhmFXzb0PKdbAVrrEzi5OVEPJ/vntWKccSyRWT+qYGTnhxmnwQ+dJI
 S1X7PqPr/Hsb7fgBrqPPNawAAAA==
To: Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, 
 John Baublitz <john.m.baublitz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
 x86@kernel.org, Valentin Obst <kernel@valentinobst.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708505639; l=4033;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=6jeuUZIWEEM6MczBBiqjTLcxOXq2Iex7vvCz0nnWibU=;
 b=vXw4UH3+h4Qo0u+jiIR3NzJr4RQ9SMlFuITEcLk/vPHJsi6whbcvNbyijjDj9XN0DjBIYg/FV
 lTfVcXooyCEDOAQGIQIh1dkqZwedw7Vykc53VahcxLmO3k1TzO3oxEi
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Provags-ID: V03:K1:8CQzPJdQOevycA67JGlkGzRtIoqyGOvtDOELvrhAlxXlRmeumAw
 cyMmaQAENoJQGOAzF5Pv8KuiJJO4FjsxaaMSo0Ix69jlCjZ1JMVGJSy8M5zvJe0BY1gZIgK
 VjGeMniG37PWoh8uMaDSBy/tZ8/S6Ib0uLef55V5Y2CUFFVfCg9Excxkvk4CpbUEZqhXNWR
 nv9Lh8Lb9a1HBI9YRKFwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BlQJO2SEwwM=;giTIobp/tT9baZQjNYx+KP3oR6G
 BKjF31uEjg5Uv1fyIwznEnBu+8XXRq3NDOvZS3btIqZvof2KY/FX68Dtzqt5t2ymgdUmJA2G1
 jV2nkbdHbeXSrTYnTBbMP1Qx1JCGyg7Fyh+6+L7epc8quLv+nwsayV3R+ij0JY54K6awOthMb
 kbzMHUkvuU4jtAy/Mw/o1JufpYcTNA4GY6ywLounjl11FwgYgAEwvYRdiZiw0+UdmCBJVRFKP
 IXpfULIavtVKTU7gMOCLlc2K2ujb1oFBw117auc7/1ln8G7XsWS/VWmjBOews1CtLKa8CxxtV
 IqkRf5hd5X/9NyKTc625iObWD2sc6J6Zt2Qe+6pOmEqah0gBqschqEugXd2siCCWmZ+zMzgBu
 viD5nX2vtqZkck6x4XGf4BjoLGIFZjrQEjknVcmTIwdVaQQrDsurQs9nlTWHxDloNFpXI2obg
 uzxJrB+EEzJeWWvXMbxY0Wzo6yMnLv8B4tz0alU407RJRgXsTkJS2cCgrRx7xnGZtBqJdDrpc
 SjkdtBcjGGQU6Isy3qxoSgD+rYbpORl5TGYODEYrGoUJlJQhd8uJovgJxRqfqNI0EmSseapg9
 QCyKUcQoaPcMKokSccIyNDSoTvBeoTpHq7HQj6BFAlRo+Txo4ZUkfB8K2qiAcohTEpLWcS+vk
 3Nd45+BXeDb922Uph/r9jwAzjwxvVEqSNgVs4+YfV9Ew4lcNqcv6/0DcJpDer6SYifJLPBtN3
 G2sPwW7+rc3yYmvqv2aeca7nXyyanr3D2Fl9E27ihoIURWCuts3JrI=

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
lines.

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

[1]: https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/
[2]: https://lore.kernel.org/rust-for-linux/20231119180145.157455-1-sergio=
collado@gmail.com/

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
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


