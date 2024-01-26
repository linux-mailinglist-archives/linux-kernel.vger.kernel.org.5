Return-Path: <linux-kernel+bounces-40813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC483E662
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F3A289881
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19A85BAF2;
	Fri, 26 Jan 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgHA32Qg"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E65B5D6;
	Fri, 26 Jan 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310847; cv=none; b=PIULzRa28GjzjPpq/+m9wDBFKZodBiZmzBtNC2p+R4d2Dk6vvdkaRaSI6rXXd2e8ZqzyxdVn6n97cJoNldocmu3EmzRqFQtmfekRANfPSWzFW7S1HQdtWDBaIlJal39q6I0W8d0edyeAGMneVmH+zjsbdhtdJNI+oTb/9jjJcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310847; c=relaxed/simple;
	bh=Bc3/rP4FzHSw4aRd7+PyEDpdKAfXelggIHNsOTR05EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9Xh3aMeRmtmc4ED6cXFBaTDsPKbp6tMUAVcy0R2b9VrBKcSTZcO4lUSn+BfBSnBrNVSpYKI2yPzVC30Zxt13rvTSyJJPJaxyKWfKNzIAUmFpiH6idtfs/Sp5lwJRSyOXkJ7NYujtxYAOmguBiy5926FlFW2yfDcnZIn0vSEpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgHA32Qg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d746856d85so7574795ad.0;
        Fri, 26 Jan 2024 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310845; x=1706915645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0a3xVOioHV0fcyUnpVH+o+i1bddgGqzpiLWHZ2ggjQ=;
        b=ZgHA32QgZpnAtQrVrojEzMEbHPKU1bHTqxtNetJUnmTsjKEnvZTS1D9FbVYrVHzIRm
         ZavUsJAC1Lh+ysEnmDzz9xA4qHFr+poTeqFIoMGbUb+GQLwsbARY+Bu2/nG0UrEjh2Ef
         JMUO1BAxUorzuwGHd/Wi6/wdC+6Vf6LzbvPfi1Xi8yU1K8bDKsr04OhWPjrDAfbi3008
         6IKR/TvNbOq8GOx9AImKNhQKzCCGkv4GnJi89NWWxr5brLQEPq4b+YQpJTF6/ob0MsGL
         5SGjTpLmb8/uMizjS/QywVBlwhxY3s1MCMEC8Y1ZJhQZUh5ldmbeq0ikMsbvoFO19F/i
         5IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310845; x=1706915645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0a3xVOioHV0fcyUnpVH+o+i1bddgGqzpiLWHZ2ggjQ=;
        b=DaIxvsa8Enl/AqajhpH7rXs9q+NkG6RhizZLrt0225M1jQM+VNPdxJhYSEoiPI7eas
         pHqAnN/fA6g70c6kKudFUTL6iddW2s3hMUddLuOUFo8FvNW0pRrmNLsqmj6R9SA2lKuY
         hebYFd7Lzv2eyMIdfmk9gMPu5xYCY1dDTqiHjDjM+MshF6Qhd8S9vpGpvuzcde04CF53
         8AMyNdwigcunrXROqVrmxfFwXUqdJCvTPUDHYvHdk9WbUx9rkNuD5XG4tzA06U1jEqr5
         /2QNin6vhdnqlwo8AJdPNGKuGpP3wJ3rvp8GUsMYCpchDcbzSzNG2PaTizR4nTnrx5Zb
         KwyA==
X-Gm-Message-State: AOJu0YyH3emG3b3o3mT929r4rMbnULw91HghG+6OHmO/slosFqoJ7qER
	j+cge/fRz7KjbH28RvZPuKONBn9E2RSctCxZ6t0Z3MuCXzpY+XHKFZNBEwv/
X-Google-Smtp-Source: AGHT+IEdr6mAEiWtPfLew47A4kjcBxvmR2F3fh8RBENWdg2dElcV3GE2TjazfBHChCjiDnYp/3wRSQ==
X-Received: by 2002:a17:903:230b:b0:1d7:4060:78b3 with SMTP id d11-20020a170903230b00b001d7406078b3mr707698plh.39.1706310845576;
        Fri, 26 Jan 2024 15:14:05 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001d76b1029c6sm1434416plb.2.2024.01.26.15.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:14:05 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/8] net: netconsole: cache userdata formatted string in netconsole_target
Date: Fri, 26 Jan 2024 15:13:41 -0800
Message-ID: <20240126231348.281600-7-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126231348.281600-1-thepacketgeek@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store a formatted string for userdata that will be appended to netconsole
messages. The string has a capacity of 4KB, as calculated by the userdatum
entry length of 256 bytes and a max of 16 userdata entries.

Update the stored netconsole_target->userdata_complete string with the new
formatted userdata values when a userdatum is created, edited, or
removed. Each userdata entry contains a trailing newline, which will be
formatted as such in netconsole messages::

    6.7.0-rc8-virtme,12,500,1646292204,-;test
    release=foo
    something=bar
    6.7.0-rc8-virtme,12,500,1646292204,-;another test
    release=foo
    something=bar

Enforcement of MAX_USERDATA_ITEMS is done in userdatum_make_item;
update_userdata will not check for this case but will skip any userdata
children over the limit of MAX_USERDATA_ITEMs.

If a userdata entry/dir is created but no value is provided, that entry
will be skipped. This is in part because update_userdata() can't be
called in userdatum_make_item() since the item will not have been added
to the userdata config_group children yet. To preserve the experience of
adding an empty userdata that doesn't show up in the netconsole
messages, purposefully skip emtpy userdata items even when
update_userdata() can be called.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index a5ac21136f02..73feba0b3c93 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -85,6 +85,8 @@ static struct console netconsole_ext;
  * @list:	Links this target into the target_list.
  * @group:	Links us into the configfs subsystem hierarchy.
  * @userdata_group:	Links to the userdata configfs hierarchy
+ * @userdata_complete:	Cached, formatted string of append
+ * @userdata_length:	String length of userdata_complete
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -109,6 +111,8 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
+	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
+	size_t			userdata_length;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -638,10 +642,50 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
 }
 
+static void update_userdata(struct netconsole_target *nt)
+{
+	int complete_idx = 0, child_count = 0;
+	struct list_head *entry;
+	struct userdata *ud;
+
+	/* Clear the current string in case the last userdatum was deleted */
+	nt->userdata_length = 0;
+	nt->userdata_complete[0] = 0;
+
+	ud = to_userdata(&nt->userdata_group.cg_item);
+	list_for_each(entry, &nt->userdata_group.cg_children) {
+		struct userdatum *udm_item;
+		struct config_item *item;
+
+		if (child_count >= MAX_USERDATA_ITEMS)
+			break;
+		child_count++;
+
+		item = container_of(entry, struct config_item, ci_entry);
+		udm_item = to_userdatum(item);
+
+		/* Skip userdata with no value set */
+		if (strnlen(udm_item->value, MAX_USERDATA_VALUE_LENGTH) == 0)
+			continue;
+
+		/* This doesn't overflow userdata_complete since it will write
+		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
+		 * checked to not exceed MAX items with child_count above
+		 */
+		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
+					  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
+					  item->ci_name, udm_item->value);
+	}
+	nt->userdata_length = strnlen(nt->userdata_complete,
+				      sizeof(nt->userdata_complete));
+}
+
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 				     size_t count)
 {
 	struct userdatum *udm = to_userdatum(item);
+	struct netconsole_target *nt;
+	struct userdata *ud;
 	int ret;
 
 	if (count > MAX_USERDATA_VALUE_LENGTH)
@@ -654,6 +698,10 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	trim_newline(udm->value, sizeof(udm->value));
 
+	ud = to_userdata(item->ci_parent);
+	nt = userdata_to_target(ud);
+	update_userdata(nt);
+
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return count;
 out_unlock:
@@ -708,12 +756,27 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 	return &udm->item;
 }
 
+static void userdatum_drop(struct config_group *group, struct config_item *item)
+{
+	struct netconsole_target *nt;
+	struct userdata *ud;
+
+	ud = to_userdata(&group->cg_item);
+	nt = userdata_to_target(ud);
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	update_userdata(nt);
+	config_item_put(item);
+	mutex_unlock(&dynamic_netconsole_mutex);
+}
+
 static struct configfs_attribute *userdata_attrs[] = {
 	NULL,
 };
 
 static struct configfs_group_operations userdata_ops = {
 	.make_item		= userdatum_make_item,
+	.drop_item		= userdatum_drop,
 };
 
 static struct config_item_type userdata_type = {
-- 
2.43.0


