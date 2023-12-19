Return-Path: <linux-kernel+bounces-5266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E8B8188B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE4F1C22434
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4B1945C;
	Tue, 19 Dec 2023 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zxutq3kV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678B1BDD5;
	Tue, 19 Dec 2023 13:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F42C433C8;
	Tue, 19 Dec 2023 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702992892;
	bh=IRSSHnu68I519nHuE1LCsW+t+yzsh069i/48dm7XrHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Zxutq3kVVurVLsiVmh8WHxeIwJ8taDRvmjv6ieT3MwVqbFV56ys1kdij2jJC12ngr
	 b6VmlvjFuVFcsXbpt8ngK1PKoUl5emAWZ3Fpk8XQnr7AXV1t8Zk+RFRVV1ehzGW0mn
	 IkYPQt9ypkpoOudg0TaB/WWqGbaQHBZZx4Wddko4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dawei Li <set_pte_at@outlook.com>,
	Yu Liao <liaoyu15@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ALSA: mark all struct bus_type as const
Date: Tue, 19 Dec 2023 14:34:46 +0100
Message-ID: <2023121945-immersion-budget-d0aa@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 92
X-Developer-Signature: v=1; a=openpgp-sha256; l=3244; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=IRSSHnu68I519nHuE1LCsW+t+yzsh069i/48dm7XrHQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNs7+23U55/0hZacGkT5lTJp+JbBD/4LlqS98suQk/f NIUT7v5dsSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEkgMZFsxPlt22Ufld58Io Pr6tV3Kb4tUENzDM4Xq+W2rd+r8Wy10Ovim+npd36+i3pQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move all of the sound subsystem struct bus_type structures as const,
placing them into read-only memory which can not be modified at runtime.

Note, this fixes a duplicate definition of ac97_bus_type, which somehow
was declared extern in a .h file, and then static as a prototype in a .c
file, and then properly later on in the same .c file.  Amazing that no
compiler warning ever showed up for this.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Dawei Li <set_pte_at@outlook.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-sound@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/ac97_codec.h | 2 +-
 include/sound/hdaudio.h    | 2 +-
 sound/ac97/bus.c           | 2 --
 sound/ac97_bus.c           | 2 +-
 sound/hda/hda_bus_type.c   | 2 +-
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index c495c6d5fbe0..4bd3be3a3192 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -410,7 +410,7 @@ int snd_ac97_pcm_close(struct ac97_pcm *pcm);
 int snd_ac97_pcm_double_rate_rules(struct snd_pcm_runtime *runtime);
 
 /* ad hoc AC97 device driver access */
-extern struct bus_type ac97_bus_type;
+extern const struct bus_type ac97_bus_type;
 
 /* AC97 platform_data adding function */
 static inline void snd_ac97_dev_add_pdata(struct snd_ac97 *ac97, void *data)
diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index dd7c87bbc613..1517d752f750 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -33,7 +33,7 @@ struct hda_device_id;
 /*
  * exported bus type
  */
-extern struct bus_type snd_hda_bus_type;
+extern const struct bus_type snd_hda_bus_type;
 
 /*
  * generic arrays
diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 3173e9d98927..1dc7965eb14b 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -28,8 +28,6 @@ static DEFINE_MUTEX(ac97_controllers_mutex);
 static DEFINE_IDR(ac97_adapter_idr);
 static LIST_HEAD(ac97_controllers);
 
-static struct bus_type ac97_bus_type;
-
 static inline struct ac97_controller*
 to_ac97_controller(struct device *ac97_adapter)
 {
diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index c7aee8c42c55..7ea274c55900 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -75,7 +75,7 @@ int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(snd_ac97_reset);
 
-struct bus_type ac97_bus_type = {
+const struct bus_type ac97_bus_type = {
 	.name		= "ac97",
 };
 
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index 4cd94178df9f..cce2c30511a2 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -76,7 +76,7 @@ static int hda_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct bus_type snd_hda_bus_type = {
+const struct bus_type snd_hda_bus_type = {
 	.name = "hdaudio",
 	.match = hda_bus_match,
 	.uevent = hda_uevent,
-- 
2.43.0


