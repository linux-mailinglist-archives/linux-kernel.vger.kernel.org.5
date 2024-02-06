Return-Path: <linux-kernel+bounces-55667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BC884BFB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D11F23946
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58801BF34;
	Tue,  6 Feb 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uLEsDdvr"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA611BC20;
	Tue,  6 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257112; cv=none; b=SfuelkJ9/kMJOs63q6FGkmh1RlwFNN7O1x11nc/B3CPjEVwoKxC+K3Wvp2cxFGH+0tCcf38XkSxDxcoVcKHu77bdZqNq8IS15HKw2ZiP3Dva4ruLSevTkmPZvUfBB2hOrDA2BrpPaVQJKUhNuVC/mcpaGWEsRnCez+ZhBpmcU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257112; c=relaxed/simple;
	bh=NDUyZqbfNLTQiXuIWY2WA7uhM6lD4SItVlaGr+B6T6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wyg5u2rdpdAguYifYzEEBc+NbLhdLnHaCnz/HT3uy7HlIayu1RZLYGC2H4sIZ1aK/gOfeeODptFfXKbPY7qCQry3hJ0kibB3yEMJji408hVVf6y/X3b++hrDvOZR4g58otIzsds0N3LO+2vfrMo0bYHyW6Wdk5aYZmKVGlKOKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uLEsDdvr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707257100; x=1707861900; i=w_armin@gmx.de;
	bh=NDUyZqbfNLTQiXuIWY2WA7uhM6lD4SItVlaGr+B6T6c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=uLEsDdvrcWRVnhprP0UrgsrOsPalld2E1M0JcDieRGAJE5iYgZFxebXpdoCKYGaa
	 AY0rBZdVEcU2rE0bn+/3FRan0EhtaXDzcX5ypU4lqkWOzV2A+Rgc/6x/a/ejo54YF
	 Mu1RXzzl9mm1NU4CbOOOCwvVVi1okaudIg6pX8AtLI0lDfWjNGor3RNcThusbbuOj
	 /xZqwtm9a16JG0bm353QkX8RZY3ruITBVw/K1VpCvnAb+YPvuNs6GUwCsLX6tZYBt
	 4ZExq3KGEODLs53Smw1RnkeEEHhOOQ6j1hdsJAFSzU8RRl5fXTxjxFCKz9CrGT/8b
	 0NfeIlguRXKiSCLA2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mof9F-1rDmwX0YXp-00p6ut; Tue, 06 Feb 2024 23:05:00 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: wmi: Check if WMxx control method exists
Date: Tue,  6 Feb 2024 23:04:44 +0100
Message-Id: <20240206220447.3102-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EbPnQIq2qjLcvrZhzs/4oVtEcQuSYO+IVBIrKFXPD+2vHJScH+4
 JecIMfiItoB59RQS5tN06+d/4reTYJVaYLgvUurGl5Pg24f1/VqZMcurTYuqS72kGUUB2u9
 yJ8LJyTkMN4aaSa8/cBdxXqXOugWhJjg9ufamjpXcuPV4jQeb2BuLtSRoNOghEnbGZN4S5/
 sSm3ArutxrZganvGU1qNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9k1+nBJUUnc=;8RH+2D2XDGPEx8aG+E9Xmp2k46V
 V/eh78PXdd72aGRQm9ypNrAB3mLEh2c7zKrmifctM1rIIu4L9g4TqAKPyU4TFdPKQTPmXVEML
 4FL20ssIeP23bVlZwYyyJkBEj2Q642Om2wfswzRiF8NeMDEZOnIil+XlznbQZUzCqPcnsHYfH
 TLvNlftj+dNLUzq+Px8vnPi3cqCQvv5DDsIQrIxusYaXohBA/eCsjBrbWYspSG1xRQp5UseP2
 AacNnFYv+EDhoyCbN8HKVHK5EDyoipSP9DpHSRQfvbAstV09rMazAXq+aEG+8mHOzfcgjykQR
 /6rN2OsU/zaEw8SnsvO9luyIFeEM3vlOFnzl1r4Nx/922aUMdtdI+GdGSKFA0Yq8YK/htdQYm
 sxs/9hl4cNs1g1c16i4ed+04ltxk9HjOk83+NXxTOaZeDoJf81io1LVMuz17jxbsNdl9qHREH
 mqqOjHtgBEaeetMEf3/1lR3yoN+7+5OMiH5fQp64ryoJZqOb6lEdETSCtWlbWsm+4gW9JRMr8
 aSN/MlC81exJEkjzSay7q2siakWgbN9ApWWR0UJMuZ7ITgbtHVZivRvXH57IO6EwENqa6fq9R
 9DB8C9joMLcn7EEUhjTFrQ1kxYHkS+iMw9N4tw0nsUwJBJH1l9LuebUxfZ4OFO7PZyPpQ+Dno
 5gvEOUV43CRHnjHCQ1bmLEhITtog/byFsfEK+SOMRqriRAN6TO7zSbRswV29Pbj1aFcLYCIQR
 J9uMbt/uu0PRlkuNRNx+ztFn2n51l9sff9pktsJvfGn2MBa3r5mRNCW9GgCGd/MTPWqlPi7mo
 8Zb9XX0wW9wEgtT/i3QLX+0HOoJmYcGafhSs2l9DzymW0=

Some devices like the MSI GF63-12VF contain WMI method blocks
without providing the necessary WMxx ACPI control methods.
Avoid creating WMI devices for such WMI method blocks since
the resulting WMI device is going to be unusable.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 3c288e8f404b..9d544c85e5a8 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -990,6 +990,15 @@ static int wmi_create_device(struct device *wmi_bus_d=
ev,
 	}

 	if (wblock->gblock.flags & ACPI_WMI_METHOD) {
+		get_acpi_method_name(wblock, 'M', method);
+		if (!acpi_has_method(device->handle, method)) {
+			dev_warn(wmi_bus_dev,
+				 FW_BUG "%s method block execution control method not found\n",
+				 method);
+
+			return -ENXIO;
+		}
+
 		wblock->dev.dev.type =3D &wmi_type_method;
 		goto out_init;
 	}
=2D-
2.39.2


