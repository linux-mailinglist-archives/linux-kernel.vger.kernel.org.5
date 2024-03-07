Return-Path: <linux-kernel+bounces-96151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7208757BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D29F1C211DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571DE1384AD;
	Thu,  7 Mar 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eE96wVP5"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10408137C36;
	Thu,  7 Mar 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841496; cv=none; b=PduHsLVtCE8pauatNgRDbstglwjX+xB1x4wJvEUM0E3G9NynTCqxG5X1p6PvMv+uMyf+BDO3gtBmkBSIPWpZjyZTuCmtom4oPGYpXnbbHQVybq6+G3yyrq9TihmYd/MpWI/LjEwLWE3lKEbs4dQkYjw8yt+3pOp/eNl0wIZfFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841496; c=relaxed/simple;
	bh=dVVO80js759j4nvce22wbRDafQcr7cFxiq3JvwZyOYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0wBZvi7DOkgC6Liqo9XyQNKtEu1JPCYQonDiC0HeikS1XPGmr8IFBxe/TyUX6zkdleQxWGRUKqG3L23peIZdbm8TFm/7uDkJzxDWhXxRidLB6nLUw2vTHyO+tlnnn1A4gvALO2PhmW8U3orxw1CiVOzUNhQzNCn+lGnJIjNiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eE96wVP5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709841482; x=1710446282; i=w_armin@gmx.de;
	bh=dVVO80js759j4nvce22wbRDafQcr7cFxiq3JvwZyOYM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=eE96wVP5omenyoQ3PEfl82WJTUkbrl16Z+HTy0/MAikyXymwen12ChVAqy5fa5UR
	 kNm94v1wuvG+f/zFRuStZUAtuUVN7zsnFZ2CQWKE7ImNMExi6TPLCBD7OGDpwITVA
	 tx/T9AcdcpStnBE4ItYRZp6N1sGcsV2OMJ8Hp/kWRxv9z+k3ClN0/rzroWyWWOrzA
	 gA1r3kkbwWecRZtnkXJ6oJX6w/eMl4UVb1aXPZzItYzwyNNRCJGCbEkVxeSIiy7Tg
	 IbzDovkYDVxL59aJ1MeJgP5DJ3XZ92cBtJFhhlVwdXrprRLNQ/3+5F6BMzNRVjgTH
	 tlqw/qtb8jp5h8HVqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MXp9Y-1rLIIA0NPI-00YCrb; Thu, 07 Mar 2024 20:58:02 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: wmi: Avoid returning AE_OK upon unknown error
Date: Thu,  7 Mar 2024 20:57:53 +0100
Message-Id: <20240307195753.2961-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307195753.2961-1-W_Armin@gmx.de>
References: <20240307195753.2961-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B1KLFHgvBUA/1PWVazQcA7KyQurIENAqhMXKuSgnGfTB6TKorHW
 ZHwSid6Km3NV7GUhbz1ph8/1TKHVcXB6dD7vBg+jvElCYARMZ/5Hw2x6uBZVlAQy9gk5ZLV
 CJB7GjkAttNvl6v5dD0av9lsONBUZusSw2UnK1Qfkymo3xLd/O32AY70pYV7G+yX8HQ1EV+
 KC9kULR8ir2saG02l0D7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4wi1RJYkdXk=;tRAdEKzXE8V8wR9rPtN9FACtYRW
 lvvlBw1YqPTZH0lUW4DEyOzTKtSXoHo5gHtKNHUCpJjcOooUgQUiKPtHqO6Cw0b2F49w6QBsg
 irzXd/1Hw9t+Hy2uIg7+W+RVukACQ21Z1+cNm7yLCfeWHhULZhUwXvZB1gX7eTnnVk+nVzXdE
 /T4DbBY29eny50i7tDQpJOq80LnLLfzrF25xIfmTY9O646qn5kAFkFwJozqibVSUROUZmGDtz
 qB3A0NdCE7ct8vHnEAOj2ERrFjAykdmDQ+ztfUe8FwriH6FYD/y1jOEhvkQejdBXvKS6CO6xu
 GwnIrkwokIrgYNMOfllTsOeSlxH2uH8p2EXxjgx/Jq0GeeOv9H85exE1vDkHt+64menvGcObA
 Yo59uzSVi1pnMO2R7JBjvfvXXU4uRPXMlU4LiNYVZFgdNWppH8E0Ve4hCDYQJoCxB+PQRhPkL
 KEzLU9ykViOJd0xsyGac+K8g7DKwwBHxhBZ/DmNtBFoREgp7VzFPuCy6NQr+XSVWUpalhwKx6
 QYpNHGptWjet4ggYHxe+OT/FF6cYs58OIRc4leVY87xklcOdfRjbAobM0eDTn+RgI3nv8iqxf
 s1ucSLQ3pA1Jvn6V3mxwsLxF20ARn5vQ3DYNE54xqQASw5VM6WhvsocuqLrfbqnf7+sOjr9ik
 KmAcqtIba1HGpVvluVJfLwixi+Diot2JCvJClmnQWJYSsfmNVaro8TbNraXO1H/Kcjlc8X8kl
 NFzYsvxGsailVgY5FfXyNNpnDCYOMA1Lt/nmz7Yj0A0n9o6Cs68LaC0AQtnEZq99z0iJuFviH
 8d7VFiTQmNDiaJ0mOyQz6QEzhY4bIlWejT85CQzNKfsUk=

If an error code other than EINVAL, ENODEV or ETIME is returned
by ec_read()/ec_write(), then AE_OK is wrongly returned.

Fix this by only returning AE_OK if the return code is 0, and
return AE_ERROR otherwise.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e542aef825a3..ad82a96ed145 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1216,8 +1216,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physic=
al_address address,
 		return AE_NOT_FOUND;
 	case -ETIME:
 		return AE_TIME;
-	default:
+	case 0:
 		return AE_OK;
+	default:
+		return AE_ERROR;
 	}
 }

=2D-
2.39.2


