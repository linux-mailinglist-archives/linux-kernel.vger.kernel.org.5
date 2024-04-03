Return-Path: <linux-kernel+bounces-128900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D122D89619E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA79283F28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD1DDDA;
	Wed,  3 Apr 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R5pE7E3O"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DACD527;
	Wed,  3 Apr 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105255; cv=none; b=GeLoezhHSqYafvNThrg19Kf4uciGBPObaYlAiMetmgn1zyGEeXPeCwneW6QlTN/vwI6yJEZZDNJt/8M5LRxVTGKlOWWqMhNpsBMu71+NqRefpSmSh7RIs28uGpCqhOL5wrBZZAvh2jWFTASBLMCy+WKjCrcnX5WPDpxt9BqR6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105255; c=relaxed/simple;
	bh=PycG9uF6X1iUrfJJtuBIh+LSC4+I0nUUV++uRc/SI80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2etIhdot7157U6YWeiSYQ+tY8+uRUGeW7wBCUJjV85peADPlxH0953f8VBT4AGA/sWZKnF+XsLxqlZuZRZJMUON9Jnvj/Yd8A4s+cu9UMMwfH+MvLMLSzea6ya6gL6xj2W6h/RGVEbxcvcmx55Yj4x8vcCnWbPh1pikHHpqDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R5pE7E3O; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712105241; x=1712710041; i=w_armin@gmx.de;
	bh=qWA45U+Q/mPj2MlS1QXch4htPzcG9qzFx8+xi4l7E7Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=R5pE7E3OWnWfXlJhppMpmo0uoUcIdrDEPgvkAQ80oVURheeJAmktS3zPwWHDU/0Y
	 Eb/dhFHL5aJ1Kbqb0OtggQEDUD1DYo3w6XCVfQvTzmDqcujg3mTE5V6cifr1Qvhjh
	 czmdlQULJKg9bCs9pi4vAd3JuzdK+tZqxyc4Yx/IiWF3DSEj7Omvr4JuYI7FQIQ77
	 clm/N3vMJi7Z2YuMfBigerMJKILOCMpV6ABe60Pz3PuxfnJ+7TlgoqgCaAcXWCw1B
	 0yVopwfhmbAXnU1FrkTSNBvJUngMgXj9hHYphawzWK/AMazuXfhpka2c16CGI5g+6
	 Kb9gmQiDDLTUnNm6Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MrhUE-1scxNV1nzo-00ngOb; Wed, 03 Apr 2024 02:47:21 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: dmantipov@yandex.ru,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: Fix memory leak then namespace lookup fails
Date: Wed,  3 Apr 2024 02:47:18 +0200
Message-Id: <20240403004718.11902-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1+/LohT4HMfkZjpcu/5lHP4fjT6BlNjAsRMOUBzgk5gIkQQT05O
 2h+PiMk0MnMm1bzN5x2a3KDSEfy4kOtNbpnKex2ZLBwowvAuKERhcRF8DQGelTWjuTglJyo
 6ra/y6IVZ9D24/EA0NIC032gmCznF+lgoKnlRC3t/Dpv7E9aE++tnxy2dj8yBARMwGdEe/6
 KIKqoyzxUbib2HQAs6cvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:icUtJdfJZeM=;kfGPWYFf7109ebjlp50NjFzPt+1
 sZWGNPsf/k5ubapg6s1UkJKbobX0InlykQgHs7STQywpZqXent1KsshMDMBgUhjQPBMcfSSF2
 6GWilxktOsotEG3x/JlwrOvcFJIk2/feS1J6DCH9kIXcnwubCN2bPjOiFL1TaxO6qxOoUvDvY
 SH5bknShaqBK4+06uuh80mVwzA+xcM5B6LLuTMt6AtawAwdmsty2dHBZI/0OHCX3+gtLSUX7K
 KAYtCY0GaCq52OdGYG5tcu5mTd5O0EZ8C3JdhWsFzK2+lPvT26844ooqPG00Ha4vwBao95h8K
 zP+RC/yYqYA0Yvrcezjs52VA2jA5hx7viCabDq6PUFiTwZRqWbv/hx5wAlJmV02vAxRa+dOMJ
 U40bjiuZdyzasARKQEPXaoJsCKOn9KqEOHZQQ8Vk28DnIRa6e5cv+buDKGMh84BaAL7BTfwE0
 4dJMExhjLrmrCgpUCyml8Mkid1j0StCUobbl98rileu0cKytdgY5FnFh6xJroAoAVW1LUn/2X
 3XvbJ9gDZ/1QhgqXeygV0kktS00GHHxNeakbMRHBctalhmQebOvkMV1mvPu2gJTxJ/l3i3QZ7
 NXveWrmcKJ3e8enpxplblq6QdKzVPVMGsSHwght1AhLlqxGLrm/eLq9Eirn/IWJizx8B+NV6R
 VQqCdmbzkwTIYSNfKVObuJQ7e+GJGyZiIJEy0bMK5ZKr3iNEltc/wjYcZwF3Qc/+WKsPE3WvY
 e2r5QJNHGChJr3Ez5iGnqYNwAM+fWTXfl6R7COFEA2MZsunjTLzDN5VJ0DYzA6lN0+5XqaOuu
 rwija1eWrs8dMMC5J8GS8Hc2J10D03RGLi+EaAaGNYdpM=

When acpi_ps_get_next_namepath() fails due to a namespace lookup
failure, the acpi_parse_object is not freed before returning the
error code, causing a memory leak.

Fix this by freeing the acpi_parse_object when encountering an
error.

Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/acpica/psargs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 422c074ed289..7debfd5ce0d8 100644
=2D-- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -820,6 +820,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_sta=
te,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_NOT_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 		} else {
 			/* Single complex argument, nothing returned */

@@ -854,6 +858,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_sta=
te,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_POSSIBLE_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}

 			if (arg->common.aml_opcode =3D=3D AML_INT_METHODCALL_OP) {

=2D-
2.39.2


