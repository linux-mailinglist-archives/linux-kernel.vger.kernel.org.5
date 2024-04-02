Return-Path: <linux-kernel+bounces-128137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887BF8956B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA461C224DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE112CD8A;
	Tue,  2 Apr 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HTG6LFkc"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052312BF2E;
	Tue,  2 Apr 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068283; cv=none; b=Cy2wnDsDtZcSefXtNR1iYIwN7v+QfQtnHLQllV65M16F3N4HXWw3FKsBfyNLOqWgndwoqVkMM9XM/5lirJqubpYU/RoO2cGbYaAQF/Oo0XJVHgTeIpEewef5/+FJmXXQG8Odb4iIxwQGQ9lbU0vUBSn+LqeEcFZIH5PHZMN1PVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068283; c=relaxed/simple;
	bh=2Bkhy71J5qlS5RrsFa5MKmbcnBZRPtNuBcoWl25nh10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqPdp748CcbijNn+mhDQJaSwqL1jvIJWIZCveAZ+yQ9OsFldaRCPi9Q9Io/NCX++KuXw93TglI1mNCw1ITdyzlj7IsOoXUfc8WUHgDl3o7MbwXrdbcy+ND4ogpRc0nnxitv9HlbZp4YTQN/1myYILYm5jtrkBaZmqIxNwtVwb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HTG6LFkc; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712068270; x=1712673070; i=w_armin@gmx.de;
	bh=VPDvKGPAbnbX62QiYPBfcbU9tv5ioaZTqMr7RjGug6w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=HTG6LFkcRV6+VDZGDgRy12KxnAlgL8jWIAPpczvfJsMp4lqdER+uq++lu83GQJae
	 S8gLopj0KwrQ2dhiTRBYOzYYeFYCQdkUyVEtun/amX47DWdeCFJG1hRMpVsAPkMLM
	 BAXJXF9KD3WAgALVUzBJCPhpRe3SkdINF/i5BMGWaSBKU9kM+wZgMVnNUpFAhF57p
	 PKt0gsSRWX1BuGQVfxxIYc3TpntSnYzXEIsCV//cs01sCdozTfAOqvPQWTxDscpKU
	 MxKV0ch3BhSTwCVVcjaFn/u/vjxfczi33R8BtxNqnmIUfICpmo8MuHH6eLj8mOA68
	 p+/eRAwbq/rAeWAOFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M26vL-1rpkQB1Hmj-002XAE; Tue, 02 Apr 2024 16:31:10 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: wmi: Add driver development guide
Date: Tue,  2 Apr 2024 16:30:59 +0200
Message-Id: <20240402143059.8456-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402143059.8456-1-W_Armin@gmx.de>
References: <20240402143059.8456-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgY4JgX5GAfRIFCjvlKFSyEYOWycN7xPHzcl6k3zcuPynmJh6/z
 vN9WF6nbxYefL4B44VRP57NQLiizn1cbMfaqA4spouBRwy0UcCtTDDks4xW1ajAbaNmXp7g
 sSClKxh6K2EcboS1YE5VQbwAW1PD81z9TZj3cl3JlUZFG+ZjCy8Bc8NCbajnLnQYzLAENB7
 weXV3GyCzQBsT7tgI4bUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QFp6LdFrmnQ=;lf6V/umIJHQngdIL3wEGH+37K3e
 dCzMX5vNs7Nzo7idEvAD3dJM/Wpx9JzQPBF5AisdXjJfGXPufs2wp7DZcA0psTOdFk9Ramgyv
 hzseaI06zD1jq6FqvwaJBrIWS3WuZsl3AkTQWOKNIB+pyE6QSfmt+Uxnur8tY//4ir7p5v7Dg
 hYk0TA/5yedfSd2lWr46EIttlB/aMixBQmbvRRithRQfzgu25qadqWjnVj8mAAFeFjt01/F9L
 FRiW4W45uFgYHKtCerroy5EGtAZjsDWOdF9Zxju+3V4cDk6+aGnThUH871EXsMcDZEElSNdvB
 xEJ5Mo5q+amTrUUShRWwn6xWxS/YBOIqXM1m7rxMmMEC8bKkbGuOg9gCAMjBxvHo0gCZnMdBX
 gCYAlI/P8F0SwhIvIdqzRFslwaONxwuPVLeh5OPEybyU63QpqVTdjQqFPDugK7qKb61oQEIo7
 i/g1SXzgtXt09d+VYAvOEuKEHnei3IsA8/163JDw0UG1iMtvlZZs0ZTpJZkHKHVlvLbTPDip7
 mrbjn6z57yJu357YfmGXCTgw0VbISWB5Lh02A4jJPjNIJBUDPJbCT6xKNtwlUvc+5cniiQPAt
 N4S8YfyZus9uFxMuJcnOBAEBpO8ric2CzUPeR/RyXGGv6dDC9P+tC352Elp8q5FMykFslxVRp
 IAqJ7whB+DKBx52W7MXMzq1NAct3WqM3yKagg/UvkOrPYEqSMKxEKGBvaJ4P2EBNHpAfqE9vc
 OmFKDIK7BoR0j++xQ2x+/S2NyjdP+K3TnJobD47o61PExk+nbGEl7AWU7Io4SScqs1G/ntm9K
 QEv7+hZJMizBeCdJYN6+EoHf+ts9BMGGIcNvY9UtAy5gs=

Since 2010, an LWN article covering WMI drivers exists:

	https://lwn.net/Articles/391230/

Since the introduction of the modern bus-based interface
and other userspace tooling (bmfdec, lswmi, ...), this
article is outdated and causes people to still submit new
WMI drivers using the deprecated GUID-based interface.
Fix this by adding a short guide on how to develop WMI drivers
using the modern bus-based interface.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- use footnote for lwn article link
- wording fixes
=2D--
 .../wmi/driver-development-guide.rst          | 178 ++++++++++++++++++
 Documentation/wmi/index.rst                   |   1 +
 2 files changed, 179 insertions(+)
 create mode 100644 Documentation/wmi/driver-development-guide.rst

diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentatio=
n/wmi/driver-development-guide.rst
new file mode 100644
index 000000000000..429137b2f632
=2D-- /dev/null
+++ b/Documentation/wmi/driver-development-guide.rst
@@ -0,0 +1,178 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+WMI driver development guide
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+The WMI subsystem provides a rich driver API for implementing WMI drivers=
,
+documented at Documentation/driver-api/wmi.rst. This document will serve
+as an introductory guide for WMI driver writers using this API. It is sup=
posed
+to be a successor to the original LWN article [1]_ which deals with WMI d=
rivers
+using the deprecated GUID-based WMI interface.
+
+Obtaining WMI device information
+--------------------------------
+
+Before developing an WMI driver, information about the WMI device in ques=
tion
+must be obtained. The `lswmi <https://pypi.org/project/lswmi>`_ utility c=
an be
+used to extract detailed WMI device information using the following comma=
nd:
+
+::
+
+  lswmi -V
+
+The resulting output will contain information about all WMI devices avail=
able on
+a given machine, plus some extra information.
+
+In order to find out more about the interface used to communicate with a =
WMI device,
+the `bmfdec <https://github.com/pali/bmfdec>`_ utilities can be used to d=
ecode
+the Binary MOF (Managed Object Format) information used to describe WMI d=
evices.
+The ``wmi-bmof`` driver exposes this information to userspace, see
+Documentation/wmi/devices/wmi-bmof.rst.
+
+In order to retrieve the decoded Binary MOF information, use the followin=
g command (requires root):
+
+::
+
+  ./bmf2mof /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]=
/bmof
+
+Sometimes, looking at the disassembled ACPI tables used to describe the W=
MI device
+helps in understanding how the WMI device is supposed to work. The path o=
f the ACPI
+method associated with a given WMI device can be retrieved using the ``ls=
wmi`` utility
+as mentioned above.
+
+Basic WMI driver structure
+--------------------------
+
+The basic WMI driver is build around the struct wmi_driver, which is then=
 bound
+to matching WMI devices using a struct wmi_device_id table:
+
+::
+
+  static const struct wmi_device_id foo_id_table[] =3D {
+         { "936DA01F-9ABD-4D9D-80C7-02AF85C822A8", NULL },
+         { }
+  };
+  MODULE_DEVICE_TABLE(wmi, foo_id_table);
+
+  static struct wmi_driver foo_driver =3D {
+        .driver =3D {
+                .name =3D "foo",
+                .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,        /* reco=
mmended */
+                .pm =3D pm_sleep_ptr(&foo_dev_pm_ops),            /* opti=
onal */
+        },
+        .id_table =3D foo_id_table,
+        .probe =3D foo_probe,
+        .remove =3D foo_remove,         /* optional, devres is preferred =
*/
+        .notify =3D foo_notify,         /* optional, for event handling *=
/
+        .no_notify_data =3D true,       /* optional, enables events conta=
ining no additional data */
+        .no_singleton =3D true,         /* required for new WMI drivers *=
/
+  };
+  module_wmi_driver(foo_driver);
+
+The probe() callback is called when the WMI driver is bound to a matching=
 WMI device. Allocating
+driver-specific data structures and initialising interfaces to other kern=
el subsystems should
+normally be done in this function.
+
+The remove() callback is then called when the WMI driver is unbound from =
a WMI device. In order
+to unregister interfaces to other kernel subsystems and release resources=
, devres should be used.
+This simplifies error handling during probe and often allows to omit this=
 callback entirely, see
+Documentation/driver-api/driver-model/devres.rst for details.
+
+Please note that new WMI drivers are required to be able to be instantiat=
ed multiple times,
+and are forbidden from using any deprecated GUID-based WMI functions. Thi=
s means that the
+WMI driver should be prepared for the scenario that multiple matching WMI=
 devices are present
+on a given machine.
+
+Because of this, WMI drivers should use the state container design patter=
n as described in
+Documentation/driver-api/driver-model/design-patterns.rst.
+
+WMI method drivers
+------------------
+
+WMI drivers can call WMI device methods using wmidev_evaluate_method(), t=
he
+structure of the ACPI buffer passed to this function is device-specific a=
nd usually
+needs some tinkering to get right. Looking at the ACPI tables containing =
the WMI
+device usually helps here. The method id and instance number passed to th=
is function
+are also device-specific, looking at the decoded Binary MOF is usually en=
ough to
+find the right values.
+
+The maximum instance number can be retrieved during runtime using wmidev_=
instance_count().
+
+Take a look at drivers/platform/x86/inspur_platform_profile.c for an exam=
ple WMI method driver.
+
+WMI data block drivers
+----------------------
+
+WMI drivers can query WMI device data blocks using wmidev_block_query(), =
the
+structure of the returned ACPI object is again device-specific. Some WMI =
devices
+also allow for setting data blocks using wmidev_block_set().
+
+The maximum instance number can also be retrieved using wmidev_instance_c=
ount().
+
+Take a look at drivers/platform/x86/intel/wmi/sbl-fw-update.c for an exam=
ple
+WMI data block driver.
+
+WMI event drivers
+-----------------
+
+WMI drivers can receive WMI events via the notify() callback inside the s=
truct wmi_driver.
+The WMI subsystem will then take care of setting up the WMI event accordi=
ngly. Please note that
+the structure of the ACPI object passed to this callback is device-specif=
ic, and freeing the
+ACPI object is being done by the WMI subsystem, not the driver.
+
+The WMI driver core will take care that the notify() callback will only b=
e called after
+the probe() callback has been called, and that no events are being receiv=
ed by the driver
+right before and after calling its remove() callback.
+
+However WMI driver developers should be aware that multiple WMI events ca=
n be received concurrently,
+so any locking (if necessary) needs to be provided by the WMI driver itse=
lf.
+
+In order to be able to receive WMI events containing no additional event =
data,
+the ``no_notify_data`` flag inside struct wmi_driver should be set to ``t=
rue``.
+
+Take a look at drivers/platform/x86/xiaomi-wmi.c for an example WMI event=
 driver.
+
+Handling multiple WMI devices at once
+-------------------------------------
+
+There are many cases of firmware vendors using multiple WMI devices to co=
ntrol different aspects
+of a single physical device. This can make developing WMI drivers complic=
ated, as those drivers
+might need to communicate with each other to present a unified interface =
to userspace.
+
+On such case involves a WMI event device which needs to talk to a WMI dat=
a block device or WMI
+method device upon receiving an WMI event. In such a case, two WMI driver=
s should be developed,
+one for the WMI event device and one for the other WMI device.
+
+The WMI event device driver has only one purpose: to receive WMI events, =
validate any additional
+event data and invoke a notifier chain. The other WMI driver adds itself =
to this notifier chain
+during probing and thus gets notified every time a WMI event is received.=
 This WMI driver might
+then process the event further for example by using an input device.
+
+For other WMI device constellations, similar mechanisms can be used.
+
+Things to avoid
+---------------
+
+When developing WMI drivers, there are a couple of things which should be=
 avoided:
+
+- usage of the deprecated GUID-based WMI interface which uses GUIDs inste=
ad of WMI device structs
+- bypassing of the WMI subsystem when talking to WMI devices
+- WMI drivers which cannot be instantiated multiple times.
+
+Many older WMI drivers violate one or more points from this list. The rea=
son for
+this is that the WMI subsystem evolved significantly over the last two de=
cades,
+so there is a lot of legacy cruft inside older WMI drivers.
+
+New WMI drivers are also required to conform to the linux kernel coding s=
tyle as specified in
+Documentation/process/coding-style.rst. The checkpatch utility can catch =
many common coding style
+violations, you can invoke it with the following command:
+
+::
+
+  ./scripts/checkpatch.pl --strict <path to driver file>
+
+References
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. [1] https://lwn.net/Articles/391230/
diff --git a/Documentation/wmi/index.rst b/Documentation/wmi/index.rst
index 537cff188e14..fec4b6ae97b3 100644
=2D-- a/Documentation/wmi/index.rst
+++ b/Documentation/wmi/index.rst
@@ -8,6 +8,7 @@ WMI Subsystem
    :maxdepth: 1

    acpi-interface
+   driver-development-guide
    devices/index

 .. only::  subproject and html
=2D-
2.39.2


