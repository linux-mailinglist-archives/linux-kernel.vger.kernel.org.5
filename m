Return-Path: <linux-kernel+bounces-123170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E861A8903A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986E328FA16
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E917131BA7;
	Thu, 28 Mar 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pF4/p4E3"
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABC1311B3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640546; cv=none; b=ixiByQ3AKGQFSyPnnRALT29Bzx1326B+DQjeRZameNgcsRpdVWjb1a5dTrefn+8kr6/u5uBUBwSNSqBhwePfqQVvqCe9Zle2BwS8rO8AxIUbYHv4wHcJSBPjvN69Wp4uwbQLSXQAwnqi/wVZFtVIKzDVidLJ35VR+L4jlgB23fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640546; c=relaxed/simple;
	bh=MbvAGUiXSvOGQ3dOWrP2pyz/s+XjyL3psabKCvzg9bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGpxFanQNKI/RO7I72NXUFNPB5RO5bx+PDPiCBvTYEeAU2gqk+CAUDw3S3axL3MMa7ZNogSy5XYufSl/KGfS6BVC20KQI3GBeTGZoHCoDtHuaM+kzBnzUxKPkRFPmhXCeocqICliCjdSTflPD3sii+r8PB/ILJiZ5hcbXgsbS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pF4/p4E3; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711640544; bh=8KAmCtUE8gnQ2PyujWn9R/x/xEPLjt7lw5xVuWHClLs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pF4/p4E3Gu9tZnZfK0FrsJu9yXkZGQ41MgMh/9+PJhLGeKy+sA/W37+ynGxr2F43BBp36XgpmwX0gTfhv7aAL7cJDwm6AURtOK2yWnC2rYm+LKbwcL6QDMd/kUuKK+NGDMJMRZkVFur6sVPnTF/Gs1NWzHv7y+nkf4TAT5X1P1XizF3ou+vg/1EL6d2KbGaB2QxCFTuNPm9+ibxaqTXsITQbK4ifpnx8j+t1IgpEY3dnl0CTB3pmqsm6RIJEACQ6mmWcL9eL/wbUW1fM0YEWr2ayJW6SImKhX4RlsT0ydxaihqiu37U1xtV7ndBoE1mgwqg3cw/z5Qw/K7UxR3QW7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711640544; bh=d/Rr+FpnJGDwk1EXAVSf9Rf0yIQZ/Ypxjn2HaBBsUie=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UwpFLJcHOog4V1RZC5j3Ha36WjRVgch9ryS6qUNNdZeV+RSftGJcvH8/l3BD5y1r9y4i3/0OOkWvYquFELo0efi/Dh0cxW70OO2Tmb6Sxr5cWD9UqltkZ4K15psLcodRXazGE/Aw1rT/S7KQpt5cxSIcitVDT9IPmEQCjqkvFK7n0V93XDND+d4YTXBPSEfqne4hXSt+2PHqy25JFY5ZlPt1V7QKM6CU0z7OfUlh0w5JpxrnI944iJ+8LWhZ7Lqs5fRI02rUPzU/0MZwmaJxrXhfXL2BDfpUnQKjsz+frsu0j/eTM4FwS3IcGckBUyHKBe+KMGcnuVFJDqgG7AE82A==
X-YMail-OSG: 3DXuDaoVM1n0o3ZKO95C1_zSwKdScpHpCUz9x38raS.NOvRK2JB_FIhqAXydzCc
 b2qNe2ajJWRKjxZjvKqtaRnY7Zbb6.KoHxF_VfjbtzAvZBXBwrw0v4JZtSYa1hn3t9UgBvviou3v
 ZELplXYpFH3qyvuXK7w2BCO7sl2do8_eTiMpXdFHta2oWq.shjQ1NL.j56gOuij5HVbAo2nSiwDZ
 c_FohEXpNyOzEjbe44eUhTZY_fZ9PLc6SaQVvBwYgl01pgY9TqZEWOvojB2xyLuxhwvjD8MprL1L
 i6D4iOTHBxU0_0hvldX5VmmWectUy3gPbn6vSpR4_3HPaw_IzU5VG0jiT57DZIeKTijFrnlQPDPZ
 l_wPHsxZnavW6.xqbhAB4WaWVPOL.CUQjNCsqO8g9GA7ecKaPGwt68m6EodN1qD3tHXmGKKelpnq
 b464CIEUF7zV.Cqbo4FhoChlB.60Z3thrvw8pA6UVaOSIAghseiEju4zNaqgIq_fVLyATebtQ.8V
 8v._cCQX5O0Ucxlazsg7aJcNMRqj9i7tLYCxIX6YmhBi47VQZa58NS90oCx163cij7zhF2TccP_k
 E_QeiHCnBNhxzYd6LrtJ60HXuW56iLaFVuU15Mlt4ynSJjf4qhIVHfBwkcnIRVKSHUT.ewFHbdeC
 PQWoYbrAE..qmvqCmElg5Fz9F1jgnRvcJnlOIWQgFkqdJoRnrULEL19jXRKiq2gNyBeJBAs48Imp
 ng7Ry2xWlYDhUaLj91OVtBNiC3VSyYpjXS_3syHRt3f8cRl9cHDd1RHOtDLBWeDotVdi8W9RDqkx
 PPIUGPOT26MGNM23H7nDOX87vZff.LzFeaqO3ZmNKjGCkNWoXAIICIBbvrSVuLMEfLdWDKbzQQJ9
 f7.7Wc8cJsew1YKFTOrM5yqeFDtZ5fscMD2dFJ50i3m2lxwnYfHtLs6D7lHJHNMO35wFtBbrzPlN
 y5Eomsh373O86D56fff1VC4w3iYxyN1JUhhatVQtAOVFoqOlBE.7t14wz17LhOlmMnfZzFlQ1SNA
 B1oGTINZOzZYb.m3Wij_sVeHwi41aq9Vx0KdW4WSskOxZtp.HfY1lJlsJRU8hoU5mfcFHsMngqt3
 ZUDDI37kuuxYIgLLy3XZdr2diFZ8PxK0qA3_2r2oSUeQ1XB9x5MHDbojy7mtmBU7NlqGTao9Hg4O
 .kFe3OOeNPOUAJD0BSqLuf_kIEADZE0iUuzQHpgyj_3QBOKDqjFz_MLgLdVIUlK60WiJy0PBPaBj
 2lwJKDlFTMz0INlaoxhMiIEzv0qebdwMJs4NANo68_9.tMuUimQQ.XHpMIur1pHKSnBXI7jeh10a
 5G3CF7jpcgrWvt7hQ_aDrZ_akfT2hWCingRs_k6GAapHVbS_.Oo2Zmbaw_J8WC2oTmHoKxOudF6r
 fKkjYrI4NMBqySTWgv1Qunm0VhVv2gwDYndoQmmVkOrEZGpq9G0RgUT_GoczbswbOGCEfaU5cJko
 4hSZJQ4TM0ri8K3gd2l_h.A9cwHHe5SLa6SPj2erM.v7xvrDKIRaspm49jDT4PCNm3lZyjzNie.b
 1.phU4Q2IbrfcxrNI5NGePY0WlLmo8BUXeWMRdUoFURdKtzbae_ZUHUHhg7KX64U20henhS27ECI
 VVzPaI5xYwzNaiQcaSyS5_iYFSqyESYkRE0IcLkthEtU2B97mmsr19ZvRNwwRnLwjvT3lOhE99fG
 AIFilJYaO3nYgJwRxS6jqiv6Lm8_KaXCkincLSUnl8b5nWrABmqUVeiNZf9E4O20_RnsqVNPIjN0
 uT7C_lfdOPAj0sjsW_uDDH8BtbDEvi4mBla_kiDyzVT5hR.zRqywyUA5X1dt9C2WW1YHIxYZvgbK
 __J9YkSD.FjV372tmZZ4hjNg9Bi5IZDJwYLIAuv4Kt7nqHrMgPBgg72dbKnO2ncrq_EtU0TLOMnB
 lebgkUIYoB.p5k6_GrjENa5aJ4r8ZsBoRPTvW0CqjKrh6Q_jbknrr3zjJlZMHXoOUN93MzTH0_yE
 Yxf5_QU_NjL6HAxC7Tek3XWZCXJ1k92NGJ_JaMoP1vwXzMt1pcpdaFga9Fj6tNyPah_3TVF8G1aJ
 An._F4of3q2SmJa73UkX1LBsUz1cdrTXuKIn6lykAfwFfUacXqfS97pATGE5nBAXgEHc1mybEEZ_
 bOjza_iZp5VuvRyVkTqUzHI58AcqDd.3p0xIt4PCDHOGoD6FfynBNniFwLeRnoLmqhaJyo59zrx2
 lQd1lvLHfWOHE3ZknjtQsc5sEq2U8q19tPPwx9PUcS_.E7Jejhuugx1BIpmh4UIAS0RBsDeM-
X-Sonic-MF: <serdeliuk@yahoo.com>
X-Sonic-ID: 0bef8a4c-a425-4fd8-8c27-cbb2ff12f9ce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 28 Mar 2024 15:42:24 +0000
Received: by hermes--production-ir2-7bc88bfc75-6cqn4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 236232f6d2287374960a372f2be4808b;
          Thu, 28 Mar 2024 15:42:19 +0000 (UTC)
Message-ID: <2795b3b7-5eea-489b-8bbd-9e2ad406f67c@yahoo.com>
Date: Thu, 28 Mar 2024 16:42:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328-dt-bindings-arm-qcom-add-support-for-samsung-galaxy-zfold5-v1-1-cb612e3ade18@yahoo.com>
 <ca4ed5e3-32ea-451a-82ca-25fba07877dc@linaro.org>
 <33e23d1c-5b6f-4111-9631-0f8db1100d0c@yahoo.com>
 <8e09b779-a18f-46b4-926c-40e2a5782d85@linaro.org>
 <20620ab0-5024-439e-943b-ab12d35a60d8@yahoo.com>
 <6b77633e-c501-4488-9b10-1881cfbf6f2c@linaro.org>
Content-Language: en-US
From: Alexandru Serdeliuc <serdeliuk@yahoo.com>
In-Reply-To: <6b77633e-c501-4488-9b10-1881cfbf6f2c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Is there anything I need to do to sent them as a series? Or only modify 
all 3 files on a new branch and send them as a new patch?

The situation can be replicated easy, modify the  following  two files

Documentation/devicetree/bindings/arm/qcom.yaml
arch/arm64/boot/dts/qcom/Makefile


Then  generate the pach and check, will show this
$ ./scripts/checkpatch.pl 
/tmp/tosend2/0001-arm64-dts-qcom-add-support-for-samsung-galaxy-z-fold5.eml
WARNING: Missing commit description - Add an appropriate one

WARNING: DT binding docs and includes should be a separate patch. See: 
Documentation/devicetree/bindings/submitting-patches.rst

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#59:
new file mode 100644

total: 0 errors, 3 warnings, 630 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

/tmp/tosend2/0001-arm64-dts-qcom-add-support-for-samsung-galaxy-z-fold5.eml 
has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.



On 28/3/24 16:34, Konrad Dybcio wrote:
> On 28.03.2024 4:10 PM, Alexandru Serdeliuc wrote:
>> Hi Konrad,
>>
>> Thanks, I unfortunately sent the patch 2 prior seeing your reply.
>>
>> The warning was this one which says that i need to send the mods separately in two patches:
>>
>>>>> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> Hm, if they were two separate patches, this is a false-positive. Could you
> push the branch somewhere, so that we can report it to checkpatch maintainers?
>
>>
>> I suppose that me sending two separate patches was not good, how i can fix this?
> Please pick them both onto a single branch and send together as a series,
> with a revision bump (v2) and mention that you made no changes other than
> combining the two in the cover letter.
>
> Konrad

