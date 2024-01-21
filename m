Return-Path: <linux-kernel+bounces-32173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F68357A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7649F1C2123C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10565383A6;
	Sun, 21 Jan 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="btQ8XS9y"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70446804;
	Sun, 21 Jan 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705867719; cv=none; b=SSYmshkJ8P6R7sI/TBxBeotwH9hjTVU54vM+0cbkUFZzWXSPR/jtFLylKPQxN+MQU5IHOiVhxxZoksrs2p+cXq/3s3cfaN785yZkY+E5inlv2AjeTsju9gKhka+cltQ8dusM8AbAaJ0SHcGRG7KPJ01CXLywjxnQjVjrRrPZnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705867719; c=relaxed/simple;
	bh=zcipHQGVG4iujMulcVGAHPb0lUqNcWYueLVlMTU7SoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MB06RFCh7Lw97F68yeMru4w/jqT1o6W2kGMPoeo0QWlrW0yMmFB/l3LuzkbDdXv5MtNySpYQTlYmLHH+at2mmo5EDbW+jcjKajfc/kUP9vMu+Ic5OaqwB2Q/rfyLUvjpWZoDCe/6f0bdgazcZqPE5sIYl96t9V454GNO4ZqtLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=btQ8XS9y; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705867709; x=1706472509; i=w_armin@gmx.de;
	bh=zcipHQGVG4iujMulcVGAHPb0lUqNcWYueLVlMTU7SoY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=btQ8XS9yhmQdl3jyipoTZoiwNQ6M0brT/9Zj0erTivHDhu1IJGU9RNQz5LAvOpFZ
	 dh7SAs04oDJOqvki51Bx/glUBW6+VkJMe4uIll+JO8y707dCM5LB8s+sz45rbwWbz
	 Oi8cJXk930mXaBrpjz2UBMc0albI0aYpN2w/Ubl2Gx2Z5x/9X+xQkjMs1Hl0mRrhh
	 g05HaA7vRNW8iOTfO+cgeYLdtZnNn8lpxCesyIhptd/LRJHpS1sfDsHwWWNCn/A/Z
	 kyAjO28J97C8QdnoBz2avNXbh5C2aiP+VcT12jP3ZzbiItNZR2P9NN/Ge3tS/UlXm
	 ersPaSzAoLgDQiP3eA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1fis-1qz4bM3cxU-011xl7; Sun, 21 Jan 2024 21:08:29 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: wmi: Use ACPI device name in netlink event
Date: Sun, 21 Jan 2024 21:08:24 +0100
Message-Id: <20240121200824.2778-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oq/lhrnk44I0MjMCdGME5clgGzdHxH8HoyOh1Du0f2gldLIdwIt
 GaxIQ4YW/P2LVjpuAVd1Np7cHU/nK2/qeORkD+h0s0M3j1vbexKBj6TkMe2BSIiWvN5Ql5z
 Q2KXtNj77tANdSIJ38B9sfiK/VWynRZCpKNsU+RRp6Lm9E3PcQautmg7IlvlrG1W4ThZXLr
 rlkv3kn0WG6ms8KENOiyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MLdxJtVrOfA=;yyDLLvp1o27sqgXhREkiIegR+J6
 /GjlpXTDP57VBH8s0h8/mXA8ZKLmroh0QrQj7Wlv1U9VhHOMYkytpEmAOm0ikYxIEtUtjpM7s
 boXBbsyk98sp2/vVkgzPFvc+Bj3QZqXydxofuuNGf+vW6UptSJbbfrj9Q4Zh5GxtkYyH2SKWH
 jYWYStWAZkfP8YujXFOxhzrfQ0FYBYl+tFFCYRB2qQKqceTL/DFron1zTeD+Gi1ty1nmB+S0e
 2A8Br3xvZWrdgcCrRvfJXQXFxBXCk2IlXLMjQXJfuEes9tLfIeGPQ7kgpe7YHTv0wyel2AU34
 Re1kCOLuYkpnNIbVPvgmQe83RjAJJs3goVSO5IUn7wk4qm+QK74qr6GHebqFWmqbL9yApivVe
 iumPcNFmVVi46JJ9h4MnP35VKKD6/rmd8xMwzDHplbWsmDjiqAyJKzYJHt0OP6HZEr1jLRUPQ
 0090oP8GMTnX9nDvm4aqG3bHGShOWYp8R8SoVIYbo0c0N0TpFTW26xTgyumM23cJitC+fAi3V
 wJPZQSwFZt3WrTsdvhgmmBWE9yN3M+0NBLcyM28WOEEHIT79tMPwogGHHwrtuBQaL5nyDVt6Y
 pCFvHSqqLvsDubJ3SZv0eluTi5ESVFCw9UOTiNtMNGmnrYfSW+dpNzngXLBFyXjCJ5gGaTGfX
 VirPz2hCgyEKzp+yPus0kWBNldDJuFD1C/WEOQBjdaZG1Neww59vHYc6QDS/FNQa3Ggl2nrrl
 EuVWiO9z/Om4U3/rcb2nRljboB+Dq1xG3z6SUr9E8VYYCfRBs6cp1adkVE18nNgqgRF74+U4v
 +hk8vnUVA+tF7g1DKtzfBld5aIADocWYJd+IPB2Esom5cvHgYenAUs4hvEMvYNMLrdTZZNlzn
 YRVNzrGN9AZEuW/Eliwr77g1zDA4rPS3IequdBd6avBMUgDnhG4fl2Abqj0H79OReXJfjZtcz
 9C2WQjGxCDJy6ygQjD8zxiEXOBI=

The device name inside the ACPI netlink event is limited to
15 characters, so the WMI device name will get truncated.

This can be observed with kacpimon when receiving an event
from WMI device "9DBB5994-A997-11DA-B012-B622A1EF5492":

	netlink:  9DBB5994-A997- 000000d0 00000000

Fix this by using the shorter device name from the ACPI
bus device instead. This still allows users to uniquely
identify the WMI device by using the notify id (0xd0).

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- use acpi_dev_name() helper function
=2D--
 drivers/platform/x86/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index a7cfcbf92432..c61860db66ed 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1202,7 +1202,7 @@ static int wmi_notify_device(struct device *dev, voi=
d *data)
 	}

 	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
-					dev_name(&wblock->dev.dev), *event, 0);
+					acpi_dev_name(wblock->acpi_device), *event, 0);

 	return -EBUSY;
 }
=2D-
2.39.2


