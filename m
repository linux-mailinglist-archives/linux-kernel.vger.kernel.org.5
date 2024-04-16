Return-Path: <linux-kernel+bounces-146404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF28A64D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E400A281D32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2A156974;
	Tue, 16 Apr 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GLtrmbVV"
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7978C68
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251764; cv=none; b=vGTJuJJPXzrH482zW9OhJmsrK8EGzOdiSCbXwdqHqbh7ZjJAX2BlTSCkFhUdXZkuOf0rwv4W6269WKHpP0emT+QOqmzyde1zuN3koAB83Eife/gePXx9fGBWRxCARLY2pC1pAqzxSEEbha+XEvG0HqZBrY/3+Fen0jx1pU1HprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251764; c=relaxed/simple;
	bh=qCnQDVa7gcBj72tko08cbYB/OWz9xGb3hgKYoiVKajc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=M+j2A7GdMQEHHzF3DJ8igSJBUt0eE9LvGJ7ellKWKSCwKcL3G64lJgdUDEtZO6FYiS/wd2nDEC80D9wWndlYIYPYxxRCgQ36zOY0iZR22hNYct8JoeF1P+Jal0KW+o0Gr/EIpQVCZhTWIlL+kCDC09XVqmxIn4gfgTczl76ZfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=fail smtp.mailfrom=fedoraproject.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GLtrmbVV; arc=none smtp.client-ip=106.10.244.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fedoraproject.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713251759; bh=qCnQDVa7gcBj72tko08cbYB/OWz9xGb3hgKYoiVKajc=; h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=GLtrmbVVR7o2jYDVNGIkcSX+Uh3I76K9btp+MquhuTBr2n7nIrD//Z9CvksOk3P1D/aipgUyXoZo2mRTjV0Mzmt1QKYVCrRX3uBmRsiS3XEi4vHJDAJ6YfT4lSu4+3Op1F/tYTtHE0TSCbZZt6rgI83er69xkSWMg8Le9UvZJyhHMHs/R+3IAZlnP0b+5hVjvgUBD5bdi701PclPNbuPbZoEqlCLjcaW6qFnoUmmNz/3sgP559+9OKp9qMYM4GOM+VwF1FSjtyHucTfZ+dqhbX3ukJq3Vsr0587NIAoPEQzKID97mRjG1hCojA9qilZLjVhtVnmUskPVNTKT5ClW7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713251759; bh=G1siwvP4ph/WCnDCmSpi/3bZJziYzv3ib4WWxYObHzt=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=CVXXRB+fuFU2aNlvPUGN5jdO0U64PBggjeV5pAsJbR+sege/JJEZ6lAsemQMXpXhOn0lfkIcU4hU/bRWkU2PbElPSD4Ko7bBBoxLeaP3CEGWKTHeoqEJz7vvd6g2WMf4TQINaPcqfb85SOuB2wMXM+IBg0b19qZ1kkbVjyjZcklV7FV81Xd9KHhNUgFkCq96IfcH+qgoCUusoGG4DyQETf0nDxFoHQmPa3dNiaK6bKC5yH+S5X930d3ENhDDeIqTgsLmA2+IYxjx1hrs/Rj55kNZ6gljp9FxyiUcZVA7/78ypt0SMojIx12mw8BL2NE2g5vjEstPFk2LYT0jYy3SYQ==
X-YMail-OSG: BkiJP0IVM1l81WW11zRqwKNWozcJMufeJPXdttWFUgDSJHZ1o4QsvcXhUC0Baet
 cEog_VVb1CvUTmOJYd_OtylWJPNjS7OqTFXkW58RV2L02dyQ6FH5ctg8EMZ9QEo3rN7SkV.w.SS0
 HYb1g_WhNSe5TlqpZBSZG10S8FxaAqEtBLf3gAXZ9QZn7FNcIhu_vXYFZcggNSoMSt81D3pmDxGh
 1wXVmBnut2bq.DwUd66sq_CmnsKTulXBpQ9yRe0iSs6bNcgHlgKR0n7MDgJeDWYcTnKaR0H4vPX4
 ef7mOUDsnoIXlVN4Iv6lQ6BqbpPw.vRRqtGDuovwRiVG5CHGG.uNa47B.dXd2db6hh_OnqXvwDub
 VNo0FAQihiUg._zqKvEz0XcEZ.kMnctdp7rIVQ4dXZ3gLAc.hxggWHQNfecKYGxTD6L9Cy18Tdzc
 joKX21ggLKZmcE_g3voNWE7BsXF6KAWgWMi3tMaQk9r.pSVkztzv8CtNYGgndDS2.XT8GwCkj6ZJ
 cBjYUOkM2Gi8pf1V07kZaoX6PgpNqwEf.FQCyfTB1rtWbrfI0ETX_Yo9YxUn2h_GCiSpzZcnsK85
 SMM3iW_Xj4bfjHhr1bhBfTxsL0PYYa3ht3YjwG6oK6fmRQfJFf3FylbH_iKNKtlo1dzJok5tBCJh
 BTv_4bIc2LMwpdagg_XOyTEt1QAjKD2k1UWsOGPMSptR8eBxcRj0lgt2vepRjKjEvbUpIlDWwtN7
 BizJBuDzgwuVkyChG4_dzE7AFq8t.Dauty5tcYcvpBJ5gUmBx09HfLZh4wYRf7SLQEyMrIso4m2g
 WqH8OJfgsP_KFCyhUU3oCpocv.wuEPGcQ_LwjuxHQoeYjr.9BI4nw3F.CLXWrIh.ssn.XGrTNfOy
 xbM2ZGgWFttty28CZwXY6D1pGCy2hb0KL6.OgvvOBb5GKuaOJC.9AmY41RuFtWmhZNkV__.ZJ8tB
 ALGQCTLTvl8FGJi6insAS.SvSO9JsPILfOSCEEyWJQ.3GIltRikk9EH3h4aDXlvT6eK_7i93Azwy
 3iTvoKETCYw7sotla3g2.SSzxPSWtewhSjPQO50OTk0A8Fwq5Mo78pojtN174DhCmVWblrSKo2Vy
 aWZVK5pyik7j2_eElIU4tRcrMQcqzex8isOeXvEhiT1s2qOzhdauk0D_hlri0740u286K0rT_qW.
 72cvpZgMmUya7zRIb1we2895GAn_YrimD14xNhS6wH8z.ZcoIbHw3DjBY7WBhp5b5YCU6Fh8_LUA
 BCseL2B8KYcbG36kML2pIrzzOJ06kg7IKkwv_TqE9zmk.0qUkyRYkhhbc0zRHBUradBqeec7vI5f
 k8mOFbWGuNn0iPDViMHmkVrubtNe_MAO4sH7dDQ5II.gsGl6Zs2x5xHl8ajOgmmfwlWOF.mMo_9x
 8IVgSS5jJ4Ko00UDn28zTWwPhXE.fDJAlDCp2FX4vnhoNw288vrvTQQ7lLJEoR7bUYJXKehC5x94
 6WhXy3IkNVP.zRKbarACS__SkOsdZ.VGwWlWrfFsxUGjGURCQ7TBUC5cOMv3mSjkUhB9TInw1wEd
 D_cafYoAt81bjRhWfpiaEveiEGN043lf4F5rPBcMVfDASMfAqCVmKa4wnHDkZUvGogznGcWpeGcE
 RpK0YuLJAJ2dGkWLuomJByDy0Bpmvbv0GMytDju8W_avx9O9thONG.SZpm2ifM5MRayt28ZC5G1D
 JxXkbe6TdALg1.ekdx19ndKSd3MVsaZKMZBRi3xxDKKFxuGIff4wirsowdcoaJoJTl8_XJKI16Jg
 KAIcEq.JnhVysHrBNy6ozw.K0gqk6MW2gDr7IjY10lRYXfcSD0RMDwoAZe4hxKqkChP4.u3suEZ2
 KPQWOhrl_9g_IVnZ9d.VG.nisUD2k_7GHPxBAuWhm2PNt2pKCXgbZGKz8czMi4GHAdjpDg7EbpBu
 wwRUsPgIQhIpU_vRkNmvF9S6g8JVA86_luacNP_F99VjFRnNr1de_Cj3l2bhNrsHoQsHZ.bMH7JD
 nBJWL5tuTw15nQsj.FlmiOUwQnEIsWh7uGSZ8E.kiNQ5VzbIzh0KtYIZZ2Vke1e2fWkR74rBY5Cy
 jdIyZdPdapZZAy59tMQ64vs24MIjMAAR1McCaJix8DYmt0k5STL2lTTACRQhgkx4dbW58QkYLz71
 UHT0UehFb.TFfPTi5YlLajTLrWn4G5WkQcQyr_RabQo1PVW1piPksovAMwxsVAYGNu3EVldl1JWP
 pYLWS4udc4cF6MQYm1xXrnzSxnLb1hMaeTgSOEioZt7r6IgbV3FSHVQyMHzWbNUmMFPO_nf2x
X-Sonic-MF: <pjp@fedoraproject.org>
X-Sonic-ID: 209efd66-4d69-40ed-b80b-1b3dc2d834a7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Tue, 16 Apr 2024 07:15:59 +0000
Date: Tue, 16 Apr 2024 07:04:47 +0000 (UTC)
From: Prasad Pandit <pjp@fedoraproject.org>
Reply-To: Prasad Pandit <pj.pandit@yahoo.in>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	Andy Whitcroft <apw@canonical.com>
Message-ID: <1568855168.5949322.1713251087824@mail.yahoo.com>
In-Reply-To: <20240330033858.3272184-1-ppandit@redhat.com>
References: <20240330033858.3272184-1-ppandit@redhat.com>
Subject: Re: [PATCH] checkpatch: error if file terminates without a new-line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22205 YMailNorrin

[+linux-kernel]

On Saturday, 30 March, 2024 at 09:09:12 am IST, Prasad Pandit <ppandit@redh=
at.com> wrote:=C2=A0
From: Prasad Pandit <pjp@fedoraproject.org>

Add check to flag an error if a patch terminates a file
without a new line (\n) character.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
scripts/checkpatch.pl | 7 +++++++
1 file changed, 7 insertions(+)

-> https://lore.kernel.org/all/CAE8KmOxG=3D3sWKpeB5fdWTK-SCipS=3DJyDE-_DNgY=
--DtoSQZ0Qw@mail.gmail.com/T/#t

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..df34c0709410 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2795,6 +2795,13 @@ sub process {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 $is_patch =3D 1;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }

+# check if patch terminates file without a new line (\n)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($line =3D~ /^\\ No newline at end of file$=
/
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and $rawlines[$linenr - 2] =3D~ =
/^\+.*$/) {
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR("NOEOL_FILE",
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "patch term=
inates file without a new line (\\n).");
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
+
#extract the line range in the file after the patch is applied
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!$in_commit_log &&
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 $line =3D~ /^\@\@ -\d+(=
?:,\d+)? \+(\d+)(,(\d+))? \@\@(.*)/) {
--=20
2.44.0

