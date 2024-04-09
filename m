Return-Path: <linux-kernel+bounces-137489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E955E89E2D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7907A2853EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C3156F44;
	Tue,  9 Apr 2024 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4hGjxCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA499157478;
	Tue,  9 Apr 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689191; cv=none; b=fS12j8iCEZCyxrWisEXj50XN2d+7W+yUkpzHYgbsDNjpEey5xrBBS0bPALbcmu9eiARd4IGOWi8i5eCChEga4K2hHetI4ZVWH2JJvHR83JJ2ZRlvNXyuYpRc4zwHCbD62Yc2wuz81wAaAo155B5lt1QmXygyQpcX68ZrCPsO1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689191; c=relaxed/simple;
	bh=rQ1wN85KvyDr48E/qDDapLu5pJUhnzdbM/cwNfrXARI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDoOCziZ2jP08DgXKv33I4r9Czf39taq7Yldtwb1WiDg+k14NK6tWNI8BF3iLNQp5vLJ4p879r9OQuKvlFhpZ5xC97LqDv9NTctmFOIp5kDmmrz1EoovKfDFvWoZZVBrHqmwNG1TvrFXTkYhc+hRK5GO8gZPsVp0p58zY/12vKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4hGjxCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AF6C433C7;
	Tue,  9 Apr 2024 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689190;
	bh=rQ1wN85KvyDr48E/qDDapLu5pJUhnzdbM/cwNfrXARI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r4hGjxCjpDkwKcy7c8SOBbtbnq6r3tyJFqmodY4ysuckS+GpEJyzaVL7r1LHXZesU
	 QLDZFtSc02R0rhF+E6oIVPCmpNiv06hkuIbtdJtSOkCXazDdaA00ICrpOGQT5j0Q/t
	 /L8VHrltviHsHAgGniO2L+40V3MouHADODO3iH8PioUIQKstIW2SdvgDBb73uzeiN7
	 IMopX8BVnFie0GnerpxMcgnfHWMk0fdt2QHMnn+x4/wWeICN9TbaMACCL3w7dWKj75
	 UzfEO2cgMKJHWw1s1uhoWfbM17QpV3zxrrl1VyeHpEC27gcr7Tm6cQTUp0UNEf+Upj
	 q0DpNp3gWb9dQ==
From: Rob Herring <robh@kernel.org>
Date: Tue, 09 Apr 2024 13:59:39 -0500
Subject: [PATCH v2 1/3] of: Add a helper to free property struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-dt-cleanup-free-v2-1-5b419a4af38d@kernel.org>
References: <20240409-dt-cleanup-free-v2-0-5b419a4af38d@kernel.org>
In-Reply-To: <20240409-dt-cleanup-free-v2-0-5b419a4af38d@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev

Freeing a property struct is 3 kfree()'s which is duplicated in multiple
spots. Add a helper, __of_prop_free(), and replace all the open coded
cases in the DT code.

Reviewed-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/dynamic.c    | 26 ++++++++++++--------------
 drivers/of/of_private.h |  1 +
 drivers/of/overlay.c    | 11 +++--------
 drivers/of/unittest.c   | 12 +++---------
 4 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 3bf27052832f..af7c57a7a25d 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -305,15 +305,20 @@ int of_detach_node(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_detach_node);
 
+void __of_prop_free(struct property *prop)
+{
+	kfree(prop->name);
+	kfree(prop->value);
+	kfree(prop);
+}
+
 static void property_list_free(struct property *prop_list)
 {
 	struct property *prop, *next;
 
 	for (prop = prop_list; prop != NULL; prop = next) {
 		next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
-		kfree(prop);
+		__of_prop_free(prop);
 	}
 }
 
@@ -426,9 +431,7 @@ struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags)
 	return new;
 
  err_free:
-	kfree(new->name);
-	kfree(new->value);
-	kfree(new);
+	__of_prop_free(new);
 	return NULL;
 }
 
@@ -470,9 +473,7 @@ struct device_node *__of_node_dup(const struct device_node *np,
 			if (!new_pp)
 				goto err_prop;
 			if (__of_add_property(node, new_pp)) {
-				kfree(new_pp->name);
-				kfree(new_pp->value);
-				kfree(new_pp);
+				__of_prop_free(new_pp);
 				goto err_prop;
 			}
 		}
@@ -921,11 +922,8 @@ static int of_changeset_add_prop_helper(struct of_changeset *ocs,
 		return -ENOMEM;
 
 	ret = of_changeset_add_property(ocs, np, new_pp);
-	if (ret) {
-		kfree(new_pp->name);
-		kfree(new_pp->value);
-		kfree(new_pp);
-	}
+	if (ret)
+		__of_prop_free(new_pp);
 
 	return ret;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 485483524b7f..94fc0aa07af9 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -123,6 +123,7 @@ extern void *__unflatten_device_tree(const void *blob,
  * own the devtree lock or work on detached trees only.
  */
 struct property *__of_prop_dup(const struct property *prop, gfp_t allocflags);
+void __of_prop_free(struct property *prop);
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name);
 
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 2ae7e9d24a64..4d861a75d694 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -262,9 +262,7 @@ static struct property *dup_and_fixup_symbol_prop(
 	return new_prop;
 
 err_free_new_prop:
-	kfree(new_prop->name);
-	kfree(new_prop->value);
-	kfree(new_prop);
+	__of_prop_free(new_prop);
 err_free_target_path:
 	kfree(target_path);
 
@@ -361,11 +359,8 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
 		       target->np, new_prop->name);
 
-	if (ret) {
-		kfree(new_prop->name);
-		kfree(new_prop->value);
-		kfree(new_prop);
-	}
+	if (ret)
+		__of_prop_free(new_prop);
 	return ret;
 }
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 6b5c36b6a758..a8c01c953a29 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -795,15 +795,11 @@ static void __init of_unittest_property_copy(void)
 
 	new = __of_prop_dup(&p1, GFP_KERNEL);
 	unittest(new && propcmp(&p1, new), "empty property didn't copy correctly\n");
-	kfree(new->value);
-	kfree(new->name);
-	kfree(new);
+	__of_prop_free(new);
 
 	new = __of_prop_dup(&p2, GFP_KERNEL);
 	unittest(new && propcmp(&p2, new), "non-empty property didn't copy correctly\n");
-	kfree(new->value);
-	kfree(new->name);
-	kfree(new);
+	__of_prop_free(new);
 #endif
 }
 
@@ -3718,9 +3714,7 @@ static __init void of_unittest_overlay_high_level(void)
 				goto err_unlock;
 			}
 			if (__of_add_property(of_symbols, new_prop)) {
-				kfree(new_prop->name);
-				kfree(new_prop->value);
-				kfree(new_prop);
+				__of_prop_free(new_prop);
 				/* "name" auto-generated by unflatten */
 				if (!strcmp(prop->name, "name"))
 					continue;

-- 
2.43.0


