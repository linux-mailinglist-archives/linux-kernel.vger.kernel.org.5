Return-Path: <linux-kernel+bounces-126287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32078934CB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D4C1C23D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9A14C596;
	Sun, 31 Mar 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlR1Q+yO"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D814BF8D;
	Sun, 31 Mar 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903530; cv=fail; b=KmKlS7aMHLZiV/rlaaCQnmRv1ovrTLnn25VwObGzqTBPckQJ7vOmkrBSJJWJyfM2bAWiYEx7NtUAJP5z0RWTcOqCA+Y9dJmsDZ+/72b6ojO2lsHN+2f4j1pbjK8+PmFQqgC10d8RpFpveMmhp7Wkrrn5D7SdgRa5fZYZID/jqpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903530; c=relaxed/simple;
	bh=SR9RnRxZpZkcRNpjLOS97nM/fnu5D0kujDzwfDoSv1g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZJBwG1AoP2kpFeesHJUzsKj7jHwsWmpf/TJSnYrCC4AZctG1dRnKILg1sUmZAUpvt2uF0Ua7WVB864hkyf3GljfDgDcLOvCmVNsE5Hn4JgYXCSM1tMp08tPa1frlf8Fv+PGYoFk22vxEeXzP7FiumfpFuVJWCVsN3CrTKLZHZ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org; spf=fail smtp.mailfrom=linuxfoundation.org; dkim=fail (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlR1Q+yO reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linuxfoundation.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EB4D2208E0;
	Sun, 31 Mar 2024 18:45:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uY3M6BbvGeJ0; Sun, 31 Mar 2024 18:45:24 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 886B520851;
	Sun, 31 Mar 2024 18:45:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 886B520851
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 79E2D800061;
	Sun, 31 Mar 2024 18:45:24 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:45:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:22 +0000
X-sender: <linux-usb+bounces-8667-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAtYymlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBEAAAA24oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 16083
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-usb+bounces-8667-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com C58B22025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlR1Q+yO"
X-Original-To: linux-usb@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711801556; cv=none; b=POt1aFf+IfZbu8zcdQgpoAGI7rhKf81N0M07DnDVLhUyB154egc7AkiXGymo3rTAQKUc8Dpoc8ZoNn/Zu/A5QQk5pBUiKnKajQWYzs4YpzAuhBc/KkZ/CG1KG+gUA1dBjkJCyn3a+dOu0vk5tS3pLE29cpfRyW4QX0Zki7WDGAE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711801556; c=relaxed/simple;
	bh=0XRUml01rr7gdHFQJBRFu9sqyJtGjnt+AjcaOvI9Ow8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C6I8YTMQnisk+3LeAnpMitXysplAT0izwqyV0uAiZwy19sFscdI9ghhAG+EtbfguT97VG40Iuq718Mb3sFkCP0r+c+eO15uvN9Nulwl8arbkrTA4Z+C1aQPawlsfA01Vnf3sJ3dBOvLao+f5l/xivTy26mKE/qnN/2M814NjETM=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlR1Q+yO; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711801555;
	bh=0XRUml01rr7gdHFQJBRFu9sqyJtGjnt+AjcaOvI9Ow8=;
	h=Date:From:To:Cc:Subject:From;
	b=ZlR1Q+yOMTjd7fPLYM4LhKvc/1peFbyPEG55fMuO2wroER6jqsmWkPa5ePWvFoRsM
	 PQDs1u/qi/DRhKfK7AwRBDRvp7tU3O47koQrQ3nAmg7gQ4MOImuxDb/qEBSSro9Unw
	 1YhEywWTlFygFAg1nzkIcmEfHU5FZw7ANjbpv/DU=
Date: Sat, 30 Mar 2024 13:25:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.9-rc2
Message-ID: <ZggE0HwcSJTQzE0D@kroah.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

The following changes since commit 4cece764965020c22cff7665b18a012006359095=
:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9=
-rc2

for you to fetch changes up to f4d1960764d8a70318b02f15203a1be2b2554ca1:

  USB: core: Fix deadlock in port "disable" sysfs attribute (2024-03-26 15:=
02:28 +0100)

----------------------------------------------------------------
USB Fixes for 6.9-rc2

Here are a bunch of small USB fixes for reported problems and
regressions for 6.9-rc2.  Included in here are:
  - deadlock fixes for long-suffering issues
  - USB phy driver revert for reported problem
  - typec fixes for reported problems
  - duplicate id in dwc3 dropped
  - dwc2 driver fixes
  - udc driver warning fix
  - cdc-wdm race bugfix
  - other tiny USB bugfixes

All of these have been in linux-next this past week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (3):
      USB: core: Fix deadlock in usb_deauthorize_interface()
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in port "disable" sysfs attribute

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Christian A. Ehrhardt (5):
      usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi_acpi: Refactor and fix DELL quirk
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Heikki Krogerus (1):
      usb: dwc3: pci: Drop duplicate ID

Jameson Thies (1):
      usb: typec: ucsi: Check capabilities before cable and identity discov=
ery

Krishna Kurapati (1):
      usb: typec: ucsi: Fix race between typec_switch and role_switch

Kyle Tso (3):
      usb: typec: tcpm: Correct port source pdo array in pd_set callback
      usb: typec: tcpm: Update PD of Type-C port upon pd_set
      usb: typec: Return size of buffer if pd_set operation succeeds

Minas Harutyunyan (5):
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: Fix exiting from clock gating
      usb: dwc2: gadget: LPM flow fix

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Thinh Nguyen (1):
      usb: dwc3: Properly set system wakeup

Weitao Wang (1):
      USB: UAS: return ENODEV when submit urbs fail with device not attache=
d

Xu Yang (1):
      usb: typec: tcpm: fix double-free issue in tcpm_port_unregister_pd()

Yongzhi Liu (1):
      usb: misc: ljca: Fix double free in error handling path

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep

 drivers/usb/class/cdc-wdm.c         |  6 ++-
 drivers/usb/core/hub.c              | 23 +++++++---
 drivers/usb/core/hub.h              |  2 +
 drivers/usb/core/port.c             | 38 ++++++++++++++--
 drivers/usb/core/sysfs.c            | 16 +++++--
 drivers/usb/dwc2/core.h             | 14 ++++++
 drivers/usb/dwc2/core_intr.c        | 72 +++++++++++++++++++----------
 drivers/usb/dwc2/gadget.c           | 10 +++++
 drivers/usb/dwc2/hcd.c              | 49 ++++++++++++++++----
 drivers/usb/dwc2/hcd_ddma.c         | 17 ++++---
 drivers/usb/dwc2/hw.h               |  2 +-
 drivers/usb/dwc2/platform.c         |  2 +-
 drivers/usb/dwc3/core.c             |  2 +
 drivers/usb/dwc3/core.h             |  2 +
 drivers/usb/dwc3/dwc3-pci.c         |  2 -
 drivers/usb/dwc3/gadget.c           | 10 +++++
 drivers/usb/dwc3/host.c             | 11 +++++
 drivers/usb/gadget/udc/core.c       |  4 +-
 drivers/usb/misc/usb-ljca.c         | 22 ++++-----
 drivers/usb/phy/phy-generic.c       |  7 ---
 drivers/usb/storage/uas.c           | 28 ++++++------
 drivers/usb/typec/class.c           |  7 ++-
 drivers/usb/typec/tcpm/tcpm.c       |  6 +--
 drivers/usb/typec/ucsi/ucsi.c       | 90 +++++++++++++++++++++++++++++----=
----
 drivers/usb/typec/ucsi/ucsi.h       |  5 ++-
 drivers/usb/typec/ucsi/ucsi_acpi.c  | 71 +++++++++++++----------------
 drivers/usb/typec/ucsi/ucsi_glink.c | 14 ++++++
 27 files changed, 374 insertions(+), 158 deletions(-)

X-sender: <linux-kernel+bounces-125724-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAtYymlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAEUAAADbigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 15930
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 13:26:13 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 13:26:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A9B9120892
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 13:26:13 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.851
X-Spam-Level:
X-Spam-Status: No, score=3D-2.851 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.1, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1,
	HEADER_FROM_DIFFERENT_DOMAINS=3D0.249, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (1024-bit key) header.d=3Dlinuxfoundation.org
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9tGtadLm7S-D for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 13:26:13 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dlinux-kern=
el+bounces-125724-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D31EB20870
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D31EB20870
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 13:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E481C20ECA
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1426B39FD5;
	Sat, 30 Mar 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Dlinuxfoundation.org header.i=3D@linu=
xfoundation.org header.b=3D"ZlR1Q+yO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD93717B;
	Sat, 30 Mar 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711801556; cv=3Dnone; b=3DPOt1aFf+IfZbu8zcdQgpoAGI7rhKf81N0M07DnDVLhU=
yB154egc7AkiXGymo3rTAQKUc8Dpoc8ZoNn/Zu/A5QQk5pBUiKnKajQWYzs4YpzAuhBc/KkZ/CG=
1KG+gUA1dBjkJCyn3a+dOu0vk5tS3pLE29cpfRyW4QX0Zki7WDGAE=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711801556; c=3Drelaxed/simple;
	bh=3D0XRUml01rr7gdHFQJBRFu9sqyJtGjnt+AjcaOvI9Ow8=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=3DC6I8YTMQnisk+3LeAnpMitXysplAT0izwqyV0uAiZwy19sFs=
cdI9ghhAG+EtbfguT97VG40Iuq718Mb3sFkCP0r+c+eO15uvN9Nulwl8arbkrTA4Z+C1aQPawls=
fA01Vnf3sJ3dBOvLao+f5l/xivTy26mKE/qnN/2M814NjETM=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (1=
024-bit key) header.d=3Dlinuxfoundation.org header.i=3D@linuxfoundation.org=
 header.b=3DZlR1Q+yO; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B6C433C7;
	Sat, 30 Mar 2024 12:25:55 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dlinuxfoundat=
ion.org;
	s=3Dkorg; t=3D1711801555;
	bh=3D0XRUml01rr7gdHFQJBRFu9sqyJtGjnt+AjcaOvI9Ow8=3D;
	h=3DDate:From:To:Cc:Subject:From;
	b=3DZlR1Q+yOMTjd7fPLYM4LhKvc/1peFbyPEG55fMuO2wroER6jqsmWkPa5ePWvFoRsM
	 PQDs1u/qi/DRhKfK7AwRBDRvp7tU3O47koQrQ3nAmg7gQ4MOImuxDb/qEBSSro9Unw
	 1YhEywWTlFygFAg1nzkIcmEfHU5FZw7ANjbpv/DU=3D
Date: Sat, 30 Mar 2024 13:25:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org=
,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.9-rc2
Message-ID: <ZggE0HwcSJTQzE0D@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"us-ascii"
Content-Disposition: inline
Return-Path: linux-kernel+bounces-125724-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 12:26:13.7264
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 6e10dd70-7823-4eba-20a7-08dc=
50b496fd
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.399|SMR=3D0.340(SMRDE=3D0.005|SMRC=3D0.334(=
SMRCL=3D0.102|X-SMRCR=3D0.333))|CAT=3D0.057(CATOS=3D0.001
 (CATSM=3D0.001)|CATRESL=3D0.026(CATRESLP2R=3D0.003)|CATORES=3D0.028(CATRS=
=3D0.028(CATRS-Transport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.025)));2024-03-30T12:26:14.136Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 10172
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.009|SMR=3D0.008(SMRPI=3D0.006(SMRPI-FrontendProxyAgent=3D0.006))=
|SMS=3D0.002
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAe0JAAAPAAADH4sIAAAAAAAEAK1YW3Pb=
xhVeiFeRou0kM8
 00TzvuizwKxatunEynqqQ6imVZY8lJ88RZAksCFQggC0AUM/6t/S09
 5ywIgiQkp9NyaAyxey7f+c5lV/736ztb8rHvuv7M8SbctIU3kSEPHc
 +U3PSnUyfifVOa8uiwf3J40O62zW7XHI+PDg8PRp1j0e502+3D3sFJ
 ++Rg0Kg1apxfOV78yA/3T5rK7PDdbrvbb7Z7zW6fd/qDTnvQPuDN9l
 G7/QbFhZJcPAjHFSNXcsfjEeB5C06VDPzQiXw15yJKLE+caNBqwXP/
 XipPuvu+mrSCeNQKzWnLRbctvYEyrYmSk3u7FYejfXjlkZiE+NLUyL
 pocuwrPvdjHvl8LCPTTuOPA1rrW52TwzaEbh2Lo3avczxqd8edg267
 Jzoj2R11Dw76pugk8D7d/n0AnCk54P9wHrklheX65j1GFfgq4q8tJ8
 QwX/NwHo5DiCtSziiOZIakQ945GLS7g+4x32t3EpKa/+OnUQNoiAki
 w5AzDPwoMQH4j49iDxjwxzycCtfFaPg4VcF0qEhaPFA+hDAF9J7VqA
 HFSoah43srlvc5v/RMN7ZAAaK3EycDZKm5JGZp3vW9STOMx2OpsAyd
 MIxlqKURR2DPuaWcB4lA4BnlYtLy0TyQ5nPIExBx4DqmAPIdwmjNzB
 748INAWonEzOwuvJI5vRxb5mJ1JpSHcGFX75mW2ZxZU64EdM8onqQb
 PpS14pHjzSkevYUWG7VT4BpIB4FQcls8gKKUHkKiim568hGK13ZCHo
 gw4jMp7/nMiWzu+WlsjZpmbB8N3joTT1pNfzxujuYD/hZyxN8pX9jN
 H4WKpsLjP+jW+Bs5GPuxZ4kIUojt9Nf/T72duuDmNoJm5Lu9N5R3/D
 zTIdCZQ3iPI9tXzu9y6HigPQYed9/kaJ9aFrfj0XAio903WIr0FsT4
 pvwYiNbp+oLT59tSZ0c+gnlIHkQDGrudZTQfdSm+BugDLNEBn0gPCt
 gE0mVEk+xhFMMwjYPAnb9Gc2e2csLIAXJO9/mFrWyhrIjvHiyNkjGq
 4QGPzdAZ8DNXCsUvfr64vhveXFyfX16/5TFBurl5zzGUZ3RtiX0Gbe
 D5kTPGgqdeFWNgFxhwoqd1T0Ez9hC87h88DYCK8CmNoTADUPsoIWsw
 tykrUOX8/OLqiv8WO+o5nBTjp7Pby+HZ2eXw48Xtxd3w7MP7m6uLuw
 toCIhAQrWHMtJDy7m/d7CoJ1IBwdmkkG1sZkiJCZbPoaUzzX55jgZ+
 ElMZ+h6/sx2Zo55DoSkCMXJcJ0KFBI9JZxaG6VjSi5wIhpQTmj5UxR
 y9vINc257g72IF2pHzBUdYnHpwyGiGI4B2hyE0O8xldKN8VybvZH8O
 7u9Cf6XFsnYjM5hCAL5S0ox0sYd+rMBFYPkwkJWYUxdYQyAWwnHdkc
 ivJm3pU2AhhzfnOLDuYKd5pq3Ggb8wk6f9UUYxTIIQ+ho1RzTnuTNe
 ePYDqagwoVVMU0qLBuN7xxMhh5kVR/PYm0PPbPQJjugBt/0w0vTZzg
 hGjjY1hivNs8JKTn2IZibuJRz3Y+VPs/rPql7efjgjB0jf+fn7Uz71
 LZmjMhEWjCitJB+hevC0QE8mjaCJwJVn9K6gw8kPnSSN2geXDp5rGd
 /H0816Ss6fAZqH02SlmhTMPaqima/uf4tlTPMNOsCz+fUknkvvqT66
 UZggd84xVzAjIzlNWEMLv0gnEj7/BS5OKwZo7H46vR2AZ0r/xfWH84
 uf+cyWmOcR3ixjNYJDGm5/+kSz5IMDiGFU4RAWpo0nW6P2z5j/um59
 szhx1Fh+DC3ZHCsp9R2CbpSwPcQyHcYenHswf6UaBtYuXa1+hYvH77
 YDl9Z40/4UunnA3X+ZIjk6yDzX5j0ulYIxBzdGy8W8QotTW85jQWf3
 PMciXB4GVHgPMr09ECGUEJ6cRBaXRG1yz6Bra8t0RRi2kgzvm3zx+c
 z5Id/ba66Lw4RqwaGYkUzEuz0Qpw8d1fla9roW7/K9PGEkds3HZ947
 XrhIPeXp0nm7qvyZdw55vgp2BumtgQOVfuLuKQ28Tailo8/8qLsGcM
 FHeoPZNKR7cgUuuG7zJz3bprXJfv9kw/NTDkF/aFlTsZLszhHPT51W
 ma1nLkldrnTgighOsrVqypfuaerXM51TFkvh9Tw9JYyPJpzW6zhyYf
 yXaei1cGxv4O50chW08Ra06Wq4AKe/SQvOB/qTEkfECvhul6cFtaYE
 F0X810zuilkXR3xTPISrlJjIVizCtZi7iybLLVmajXporOnxo5xxoc
 VxVNIjiwr68QnreG+hR0b8pJ3XWZs99gWD9tL/wZNwU3G6eiII6OwO
 z/X3x/wOJzC478HS6lDpHsHx4sLNT///gPU97x314QgI4f6P9+ndvT
 ffwx/ux3CCuVKvNOl4YazAitusVmHVEiuXWWWXtUpGuUDrBVYqGqwG
 X1baYoUto1BlrGpslxgrsZpWhHWSLNZYfYttFwz2AwP1IpjS6/DVlr
 OLYPYVK8F6CVRoBezAK8BAR6wAMNA7maqybVgp4i64Lm+z+tOorrS7
 glFchFApshL8MNgWrGsviQxZriKAUp3tZFTKC4+gWKuSU435BStByG
 UQJswQjo4IZCqsQeGkZl9ocrQd2IUnCJdYXStCpAWiq6IJwd0dUNdo
 q+RCoy0iDxhpCUNOXtMvrFcRUr1ssAaB2SJrJXxFxmD9O1Z5yV4V2E
 +0XjEYMxDGCr2A5M+sCDxss2/SrQW8ld9VNPVUahoQdeqijDFCOBB+
 kmUKs76N2StUjVqKpIRpQvYWsKsJ58jDchdWGuwFcbJcLxBsjQpXDL
 ZN8KoZpyXWyNoBmW+J5xKJUV7wmYVElpFhyiNBylCXmtphDVJP2AAG
 QHIzNA2DjLCdRTsAjDoSUsOkG6U1FRDWNaNxUqmzMrXbMlgylZQZ7o
 KRraQwEuHEYJkaAcQS+YWpbaxwLLy60cjGnhKrqU5XygtT9UWdpNFp
 +/QjUaECKOpAaAi8yK5TqaO1slFNXS/KrKQrX+sSTuyvrGSaYoJUQ1
 RGeWmHqNNQ9VN/Fw27Q4yVN9NUxqRUNGDN6rekSPOtim2byVSWlqRJ
 CVVRh5wpGI0npYIaRw8BPa+SOWAkWahWlhTB4ldbjG2xV6uLX5NkOV
 2Er2G8Isk/pYtg3DBe0mIjT3JnuZg0DmzVaesv6RYgN4wXtFjPA/bd
 chGg0w/D2FlzCuQYxjeEuZIuAg+LkCur8L7Ki25jEd2VMryVn8ecCT
 xZTDqRol6DsRHLS72lh2GdCnuhleRLPxd+v07zq7OQlUwH+5qFzHqN
 jOz9Ifll7krZ3KW7taQSiribhEMHrrGtT72a8VL/2P4PwY6oA3MZAA
 ABCvMBPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2
 Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZX
 JzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBTdGFydEluZGV4
 PSIxMDEzIiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVtYWlsU3
 RyaW5nPmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPC9FbWFpbFN0
 cmluZz4NCiAgICA8L0VtYWlsPg0KICA8L0VtYWlscz4NCjwvRW1haW
 xTZXQ+AQ7OAVJldHJpZXZlck9wZXJhdG9yLDEwLDE7UmV0cmlldmVy
 T3BlcmF0b3IsMTEsMjtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMT
 tQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFr
 ZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMztQb3N0V29yZEJyZWFrZX
 JEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQ cm9kdWNlciwyMCw4
X-MS-Exchange-Forest-IndexAgent: 1 3009
X-MS-Exchange-Forest-EmailMessageHash: 1593CEE6
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

The following changes since commit 4cece764965020c22cff7665b18a012006359095=
:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9=
-rc2

for you to fetch changes up to f4d1960764d8a70318b02f15203a1be2b2554ca1:

  USB: core: Fix deadlock in port "disable" sysfs attribute (2024-03-26 15:=
02:28 +0100)

----------------------------------------------------------------
USB Fixes for 6.9-rc2

Here are a bunch of small USB fixes for reported problems and
regressions for 6.9-rc2.  Included in here are:
  - deadlock fixes for long-suffering issues
  - USB phy driver revert for reported problem
  - typec fixes for reported problems
  - duplicate id in dwc3 dropped
  - dwc2 driver fixes
  - udc driver warning fix
  - cdc-wdm race bugfix
  - other tiny USB bugfixes

All of these have been in linux-next this past week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (3):
      USB: core: Fix deadlock in usb_deauthorize_interface()
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in port "disable" sysfs attribute

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Christian A. Ehrhardt (5):
      usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi_acpi: Refactor and fix DELL quirk
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Heikki Krogerus (1):
      usb: dwc3: pci: Drop duplicate ID

Jameson Thies (1):
      usb: typec: ucsi: Check capabilities before cable and identity discov=
ery

Krishna Kurapati (1):
      usb: typec: ucsi: Fix race between typec_switch and role_switch

Kyle Tso (3):
      usb: typec: tcpm: Correct port source pdo array in pd_set callback
      usb: typec: tcpm: Update PD of Type-C port upon pd_set
      usb: typec: Return size of buffer if pd_set operation succeeds

Minas Harutyunyan (5):
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: Fix exiting from clock gating
      usb: dwc2: gadget: LPM flow fix

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Thinh Nguyen (1):
      usb: dwc3: Properly set system wakeup

Weitao Wang (1):
      USB: UAS: return ENODEV when submit urbs fail with device not attache=
d

Xu Yang (1):
      usb: typec: tcpm: fix double-free issue in tcpm_port_unregister_pd()

Yongzhi Liu (1):
      usb: misc: ljca: Fix double free in error handling path

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep

 drivers/usb/class/cdc-wdm.c         |  6 ++-
 drivers/usb/core/hub.c              | 23 +++++++---
 drivers/usb/core/hub.h              |  2 +
 drivers/usb/core/port.c             | 38 ++++++++++++++--
 drivers/usb/core/sysfs.c            | 16 +++++--
 drivers/usb/dwc2/core.h             | 14 ++++++
 drivers/usb/dwc2/core_intr.c        | 72 +++++++++++++++++++----------
 drivers/usb/dwc2/gadget.c           | 10 +++++
 drivers/usb/dwc2/hcd.c              | 49 ++++++++++++++++----
 drivers/usb/dwc2/hcd_ddma.c         | 17 ++++---
 drivers/usb/dwc2/hw.h               |  2 +-
 drivers/usb/dwc2/platform.c         |  2 +-
 drivers/usb/dwc3/core.c             |  2 +
 drivers/usb/dwc3/core.h             |  2 +
 drivers/usb/dwc3/dwc3-pci.c         |  2 -
 drivers/usb/dwc3/gadget.c           | 10 +++++
 drivers/usb/dwc3/host.c             | 11 +++++
 drivers/usb/gadget/udc/core.c       |  4 +-
 drivers/usb/misc/usb-ljca.c         | 22 ++++-----
 drivers/usb/phy/phy-generic.c       |  7 ---
 drivers/usb/storage/uas.c           | 28 ++++++------
 drivers/usb/typec/class.c           |  7 ++-
 drivers/usb/typec/tcpm/tcpm.c       |  6 +--
 drivers/usb/typec/ucsi/ucsi.c       | 90 +++++++++++++++++++++++++++++----=
----
 drivers/usb/typec/ucsi/ucsi.h       |  5 ++-
 drivers/usb/typec/ucsi/ucsi_acpi.c  | 71 +++++++++++++----------------
 drivers/usb/typec/ucsi/ucsi_glink.c | 14 ++++++
 27 files changed, 374 insertions(+), 158 deletions(-)


