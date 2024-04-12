Return-Path: <linux-kernel+bounces-141975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046818A25AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE2E1F2221B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25DB1C68A;
	Fri, 12 Apr 2024 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IV8nelu5"
Received: from sonic303-20.consmr.mail.sg3.yahoo.com (sonic303-20.consmr.mail.sg3.yahoo.com [106.10.242.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266821BC56
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.242.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899338; cv=none; b=lVu7Z7SjWNEQpI6sWKiYS2bDTXaY0yLAw+o1kYilbob1SF7gcEBod/8VgDHKVJc9oSPRSr6HsQD8Zx28M+uXUg4yJoBJtIko5m6pP4HHX1IhTCASBgoIQuInkKJwUkKyMDtids9nRYZ7zLVjagxdvQEvWZt6LC+mBgJYgUIhdqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899338; c=relaxed/simple;
	bh=MnfUGK2l1kbzgviYp9fiw50u6LKYM1wSBxbOrqlcFFc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mv4Acc0OELiFUPOBH/uvtZG/1sCkCkaOBU6BSj9ps4tsMyedBTeR0sRYWI2ymeIGnsZeaoNklw7MHgpDVUwfmyNs00VHk3XkUmD/h9T4eaLPnnj/95HJHL/VSFzRGBjSd6Prt6rbtCXZdyEV647TAIEIMKqvWKh/UfET0Ywp3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=fail smtp.mailfrom=fedoraproject.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IV8nelu5; arc=none smtp.client-ip=106.10.242.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fedoraproject.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712899327; bh=MnfUGK2l1kbzgviYp9fiw50u6LKYM1wSBxbOrqlcFFc=; h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=IV8nelu5G4fw//55zx8n977KpZHxtVWLdxYEXrm1CGS4D8ypz4Wvy8J9RIT6SVvzgHL4/ZP8cidH58zus6Igu3cxIs5y8X0w47nL2bddawl0QbVN0MEi0LXirmdrkrNykz3zcJN+/uHxJbRWRMKttWE+xn4Lhu5ibhgedeXGhom0f6/fAeGcwVV/Q10ukKJz+vrIGRuE2PIsXJZHZ7bubYX0CLkKP43AGPNKvhSCiTPItKzeLoFrh1A6bzQupc3ozlvBCF+61C3yZoHWAzul6UgCj0BRhZC89oPeK9DA3exOYif/VUTXyCNSayJdPfWlZC0/GN4x/A1KCxrBc6nrNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712899327; bh=cV8sb406MVZs1afK79/v9Hsd99bVy3QcUyUQz99k1Lp=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=pk20N10AXEC8xLSwSJa5QkQdHUWotW4tZDpYXo88+Om6oBAbWb0s3QF4czlwwbrZGbuh5tV0DYQ8gbQMUeIWht+BhhvU7dUsepeQ2/wiV5UTUcwJMskI6k+skNYlTHTIQqUkoMPSMqRunxWwIXSsduf4Mc22JWJbXDfDe1BvDWPaZV3994n5rX7wqkqEFX7Q4QzOf7f1y7O49X7RbaBGH/Q3PRpqREO+JBRD8hMimFu7Yl3/277zL5EHmngEJW2HSCajffrhZWEh3Rlt/DDq5BeU/jORLluiniA/4xB4HaXYMzobUVgEMU7xrSzZypt/5V5CabwwqftOq2/b6dQ4bQ==
X-YMail-OSG: ddKrqecVM1kc9rby6IBS1vUBw3qIYEo21H94jTTzZjYFfL71mvFdg_SuefWAhOv
 FgvmSxj3kMLZXGujnBZoueZpVxBWE_3rqXw0tqQHcmn468Osvf4txi_mK3LyPckrz1ubUw.BJIbK
 RL9OHl1u9gqMr69u7KiAj0Q2qeIuKuorfb6mezbdxH9Mj50XD4yRkUb7zKgIbQT2lX9qHFQeOZJa
 LE.FgaWE419q8eDTAyJTOxIQxxmv.tVxGKgKDzkjma61T6cwbRGhrlXltectLPeEvdCOrvVhRZzB
 xivy_SPCd9QPli8OBougWq.WTgyQVQl3XEOsolXGdqt3TD5w10iAo8RbyfdabNHl68NyTvwsmS21
 a7FDZ4qJzZz2EI9c3VcXvCjKf7FKvEsGUdYQfLGp0fSoFPxFIR3.rFBAPel6csoNBvwfl.SCiWdH
 .lVitGAGemgsudEQmci.aw9ReSNFVcP.XlMxjRKayVMa78ZNNwYDRGpxL6StITxGAN1G0zY_M8.v
 kNmxPhtX1e2fZJAcBDJ7IPcppaSclTWR9JGoJq.svOmGdHvWMAvD9K6UYjffGX_0Z21Vd_kMLI4t
 JLI5eyUUA58D_AOUarWjZapFbjGswWNrlvJyYnaJg7HgJHpCYrvFaurp4yhqa_3QoPOMb2lXO5FG
 d7tyyp8lDBiaKRKH2lRXuv6mrIXOk0bOZObrOYX1ZA_55IiYsQcDtnXgW3sJF_FzcDPOhEiBqkgn
 yjRwFoywen9LK5o1k7ipSLkkeUcBOQf74D.iQSV9JcX5L_iEWSVpJB505mKxfw.hoFpqF.8HkYQX
 qdwBRwRGkW_FcGKcZMf0g8ej3RMXhjX6hlskV8i3tWhJeyC6F8W.ymeGCige5mL8vzkVKYwyXq0M
 CMxdGAtcT_PqvE1QFJ4kJ8hgbkJbOjJ7UJs0cJNKejb0XcfDMhBE39lqROnydWA5JTKKNRhyDBhT
 UDBRctu50lt0zi7opyV1ehfvXu1dVN4I3KLQgLNsJf2SdGFDm0WUELTvQXvwiGnhquxzb_paNj2i
 UynAj6ZWYmN8T5H4MIdVeGiUeBKh3DI4vUeRhoSO3N8GWRk4ZEeJeG3Khv4RRM5BOFFmUo2y9nOV
 y9vCTJ0g5so_DWBe3DZhiLYu5truis9P9DCYHaGYstS7PpkkrxMv82TNiwYjFz5utLmRozekdCr5
 JdNUvhaTPOGNBZJ.VvFa6hWTEkysP7FfYUNuG4e28fycruxq39YH5sQC1ph5QzXHXfir6ptO8f8I
 _JHC86bH8HTQsG16pmWGmvbQQFKJ3zPV208.a.S50hmqvNYSQzVbFDGJIhTTYSKzdYhn3GgAq9nv
 PdbKC74XaevPkKPXndeN.UYY2NqYwe13Z_l.IBV0Am4t4iHbAJYo1UK4gJe6MpoUIX_tTNCM86Bv
 tjfTn4IhNozu9uv_Sg97_MCKTcu1pokjhuMMDHgXUjs5jfI1ksKXDJzuAGi3seW8X.0ayYufGdOz
 k4zGrDATr945AyfGYMFL6NSyTMn.kxs2vxU.U6pqHHY.IWvimDum3K5hyWHbFg1S2XJzvPen6IzG
 4sRWz0_OcsFyeLjFWxil7GFaj2mKUPYNy0GkmiWOVgi0ipzNicQ6I3PAE.X1caLgojvg.iJwYuQm
 RLdwr6nbROevSuaauXVy5lka4h3tsNAFUKFnRgJZTZ881WLKQwPvCKWCeLgnjdiaOcaJPKnS8ac_
 gfj3apLbpAh6AGZ4nD8P_6YYcHIPGPvY5oV6jeEJm9634fm9ohRdfAgGx78YvYIUDlBgYZihFjYB
 hA7pyEj0zbkI6bGXYh.YzN7FklyS9tBdRt3ckaa85OLFdqw_LOV.yLD6buwiOCT59_hq5hd4IFUJ
 bQFUTSv0_yfWdJHeTaYvwjFUmNS0NewTxIZEdQzURwLmfe_IFf05JORk7UiRJiS6_9K3yk3F0EBl
 saBf_71UZg3cfPOztSmsDcKweFEr8CShJ8dFXErqdKTbcvgG.Sop7wHPhahhflgkt9DN0iYSns83
 iZTxTAVaWKvVXYy8gRihKgwY0UfrSnXO76LwbK1mt2ujVDKDN7el6.mePy78OGsa9cFqSXWCw79M
 TPR5ek1yqiL9uvI2uOIzHWtu8ctBc0KJC5KuOTDZAnKayzkKjWn5SOFjC81UeIuY6omzA7mZdCdy
 D7nHUR2TVlYDZDrmK_XjpdF0HZCJtWePQYGKJTfFdYp5PxhO7oXuAUrACGlvyVoVAJlwUPYT2bkH
 dsxXnBnjyeugy4WYkgNn7I3_lVEIjtEN1wMyZNfwPCtddD0Cuo24l8fb.l0Zc59osKDidc71tC0v
 W.4uNdDDnTFwhOIL2sIec67AgrQ--
X-Sonic-MF: <pjp@fedoraproject.org>
X-Sonic-ID: 69211c93-e240-4ffe-a3d9-613ae2f51ea5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.sg3.yahoo.com with HTTP; Fri, 12 Apr 2024 05:22:07 +0000
Date: Fri, 12 Apr 2024 05:22:02 +0000 (UTC)
From: Prasad Pandit <pjp@fedoraproject.org>
Reply-To: Prasad Pandit <pj.pandit@yahoo.in>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <292030286.5066638.1712899322325@mail.yahoo.com>
In-Reply-To: <2024041235-seizing-thirty-6ce9@gregkh>
References: <20240412050502.65326-1-ppandit@redhat.com> <2024041235-seizing-thirty-6ce9@gregkh>
Subject: Re: [PATCH v1] misc: sgi_gru: indent SGI_GRU option help text
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22205 YMailNorrin

On Friday, 12 April, 2024 at 10:39:40 am IST, Greg Kroah-Hartman wrote:
On Fri, Apr 12, 2024 at 10:35:02AM +0530, Prasad Pandit wrote:
>> v1:
>>=C2=A0 - s/\t/ / at line #431
>>=C2=A0 - CC public mailing list
>
>v1 was the private version you sent, this is v2, right?

>> -=C2=A0=C2=A0=C2=A0 default=C2=A0=C2=A0=C2=A0 n
>> +=C2=A0=C2=A0=C2=A0 default n
>
>This line should just be deleted in a separate patch as it is the default.
>Can you do this as a patch series for v3 please?

Okay. Thank you.
---
=C2=A0 -Prasad

