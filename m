Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF3B7CB6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjJPW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjJPW4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:56:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B2B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:56:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b9e83b70so37785447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697496992; x=1698101792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3smAdDTzn2P0VCmFOhSk5tC42b6tLqqxOm7kRDHbaEo=;
        b=L/kZ6nCreQEjcpsRdlbqgYnKkLDwU+nq36sodt9Y2vDq/z7Sd3mJbx7dEkH2tO8wcE
         EIUjne6Nq77Z1yw88d/3yJ/gDKAjgfPgFPIbDWy3F1BIl+OQexKZcYptDtCzpbbSpmfI
         UHRlM6l5oe+odETxmoC5kOqD0QZloG4xkzlX6L6fWEDeuOYqvE6VwSDGbopNKirFEg9G
         Ga70PgeOgzdc7fuFlTLRnNSoUOhU/9+GIUm9efhTN1nZWYCQ18+1cbQLF3fe9fmDAwV5
         /Xa9HbYb15jpMnmKLh5QI2s7cn+C20q4BRkIO0r+faeCP+9AAVcFflw5QwLBdCS+eaen
         cJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697496992; x=1698101792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3smAdDTzn2P0VCmFOhSk5tC42b6tLqqxOm7kRDHbaEo=;
        b=akWAj2Nw8G5Foc8Rsx1mbXuyI2SMr5HkRMJJwAEEutbso/ma5WPd7GflMs42mV9TFQ
         0bBaD9vc6y0GM09lnHYn+PZavAb9QLLWdx/mzbPnQq0FrQLj8SxG/zPsx9umTqK8Qomg
         RoNRE63yKetKDWTjSJD95PWlnzZTSbVviG/VM7+OLtLXN7poXFNyTV/9QL5feppfPqmU
         sZwhQnwSiiRmrWwKWQk8sLXTAmYgw9cRQ5pK7r2uJd27qrowb+s/gOnKhB49h9Gg1lJE
         g8IGB7ZLskaz7pc/+34v4SjVIAk55wPjv3y+KMJNr0qGZW1UuA7nEyMcmb1mkpRVRwnH
         q64g==
X-Gm-Message-State: AOJu0Yxbt4D445nndvc+/+yptAOL9gKFNOebJ1QeWD8DFQgAqE/89/kt
        JHzBccW0sXQDxIVwdMBEbO5QTtlAFR1Kwgk=
X-Google-Smtp-Source: AGHT+IH5eUfE57xNCRlerq+1ZHFC/TYz3mYH4cw8P3ZRB9L9IsWtGcb0/cu8cD63zfhQ4OYODSU/yt3GyB3bgd0=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:690c:2f05:b0:5a8:207a:143a with SMTP
 id ev5-20020a05690c2f0500b005a8207a143amr7161ywb.0.1697496992644; Mon, 16 Oct
 2023 15:56:32 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:56:18 +0000
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=rdbabiera@google.com;
 h=from:subject; bh=ShV0SNy5JY0KPfr6JnaQ4ZB+BHZ8LD1b/XS6KEqWo7g=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKm6+yetf9DyVb/nUv+2mz3Xus5nHHTe6zTd7F9ceuG7o
 GsJXhXXO0pZGMQ4GGTFFFl0/fMMblxJ3TKHs8YYZg4rE8gQBi5OAZjI1CxGhtZdD5P+T18qu06n
 WnLD/Gl5dz4cClJk/7am+ufHBB0//9cMfzi6dWdWJ67TcXW5HK309eu7Ncn9ig3nJvMWvirj2VW 8mgUA
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231016225617.3182108-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: altmodes/displayport: verify compatible
 source/sink role combination
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DisplayPort Alt Mode CTS test 10.3.8 states that both sides of the
connection shall be compatible with one another such that the connection
is not Source to Source or Sink to Sink.

The DisplayPort driver currently checks for a compatible pin configuration
that resolves into a source and sink combination. The CTS test is designed
to send a Discover Modes message that has a compatible pin configuration
but advertises the same port capability as the device; the current check
fails this.

Verify that the port and port partner resolve into a valid source and sink
combination before checking for a compatible pin configuration.

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/altmodes/displayport.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 718da02036d8..3b35a6b8cb72 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -575,9 +575,18 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
 	int ret;
+	int port_cap, partner_cap;
 
 	/* FIXME: Port can only be DFP_U. */
 
+	/* Make sure that the port and partner can resolve into source and sink */
+	port_cap = DP_CAP_CAPABILITY(port->vdo);
+	partner_cap = DP_CAP_CAPABILITY(alt->vdo);
+	if (!((port_cap & DP_CAP_DFP_D) && (partner_cap & DP_CAP_UFP_D)) &&
+	    !((port_cap & DP_CAP_UFP_D) && (partner_cap & DP_CAP_DFP_D))) {
+		return -ENODEV;
+	}
+
 	/* Make sure we have compatiple pin configurations */
 	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
 	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&

base-commit: d0d27ef87e1ca974ed93ed4f7d3c123cbd392ba6
-- 
2.42.0.655.g421f12c284-goog

