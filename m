Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A17536B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjGNJgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjGNJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:36:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE6358E;
        Fri, 14 Jul 2023 02:36:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 64EE65BC9C;
        Fri, 14 Jul 2023 09:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326380;
        bh=xxvykvXcInvkp1nPJDBq3/LVlq3218mtzs6EEpgOuZM=;
        h=From:Date:Subject:To:Cc;
        b=SW7iC9PLblGwjy0uS43ESSW/CTTwGFLyA7BXzUeLnZBlYYClQOkSR1914QK8OPVTN
         whb4pXHsb8MzNqGrVxrGB2h9YLO9wpjogxw0VaaTMpEYJ4mc91FSi4tklMSZOvQYkg
         wa/lTzit4twzHZblAKxWYbB8IeWNCxSsnLOBfWc4JZQTi1xuCY8jaLuFSDIVdA0ubs
         nPmlbDtM0sbXxSy5V4YgYSoSVlsNLJe/tSrfJ2WXFdelBflnNAoFy5mv4YA4cpa7oy
         GyGrWGIvE0CvrssMJkX9Pd+m3hv64csNorB9EImvr5ZJOn6s1Ds19IHuekrBv5flOX
         BfJy6V18tUZlw==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:19:33 +0900
Subject: [PATCH] rust: kernel: str: Implement Debug for CString
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
X-B4-Tracking: v=1; b=H4sIACQTsWQC/x3MQQqAIBBA0avErBPUAqOrRAvT0WZj4VQE4t2Tl
 m/xfwHGTMgwdwUyPsR0pAbVd+B2myIK8s2gpR6kUaNwfGVKUXjc7iiclVoFlNabCVpzZgz0/r9
 lrfUD7QtijV8AAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326377; l=768;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=xxvykvXcInvkp1nPJDBq3/LVlq3218mtzs6EEpgOuZM=;
 b=eVRCUCVHz0ocxsEaLFf7fiwn6ZrnWFVt5xgQ3D4WiHheqp897IEhKoC3DVZkJwIzRl/SZn53S
 StVIW12Q8yoBFVBQFV0Nvv6Vka2cl6ohbzDV152N+F9M7CFK9B5N658
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial implementation.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/str.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index c9dd3bf59e34..a94e396d39e1 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -606,6 +606,12 @@ fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
     }
 }
 
+impl fmt::Debug for CString {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
 /// A convenience alias for [`core::format_args`].
 #[macro_export]
 macro_rules! fmt {

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230714-cstring-debug-ca021fe0ad78

Thank you,
~~ Lina

