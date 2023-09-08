Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EE798E99
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbjIHTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjIHTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:02:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D18E65;
        Fri,  8 Sep 2023 12:02:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4386EC43391;
        Fri,  8 Sep 2023 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196203;
        bh=vHsETvkSirYxdSRhZIK6BdPFT7z4sK535UZt4xBWOpg=;
        h=From:To:Cc:Subject:Date:From;
        b=djWxNR8fV/RCHAoXeNh1GJUHcrWsA2bKVPE2EgZtNozqDxCx6w1hrRFsHlvsYyhaC
         3kpBCr8Ee9ygaYfheJOxQWeiBuaI6XdLchrdwaoTuUOHBQFqXTrbXmY10fiSiaUt9Y
         3OnQPrclN5pI3LgeMyac5eeUCqe60O8xlzDL8IVB8usIzXQ1CekTfk5UNDs87b67nD
         rNL8Yz8Y1tHXvdA26asRMMbLPcladDzK6qcxAL+7hr9DcYUDEFjGPXeKk14AsPChK/
         LZOB+sg8OVC09DBey3MEgYnvF7EeNClvf8cGFAujMQLP5WnRxC9l2lNZNXAZS4g6CG
         PkHGwxg0NEoyw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abhishek Mainkar <abmainkar@nvidia.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Subject: [PATCH AUTOSEL 5.10 1/8] ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer
Date:   Fri,  8 Sep 2023 14:03:12 -0400
Message-Id: <20230908180320.3458596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhishek Mainkar <abmainkar@nvidia.com>

[ Upstream commit 3a21ffdbc825e0919db9da0e27ee5ff2cc8a863e ]

ACPICA commit 90310989a0790032f5a0140741ff09b545af4bc5

According to the ACPI specification 19.6.134, no argument is required to be passed for ASL Timer instruction. For taking care of no argument, AML_NO_OPERAND_RESOLVE flag is added to ASL Timer instruction opcode.

When ASL timer instruction interpreted by ACPI interpreter, getting error. After adding AML_NO_OPERAND_RESOLVE flag to ASL Timer instruction opcode, issue is not observed.

=============================================================
UBSAN: array-index-out-of-bounds in acpica/dswexec.c:401:12 index -1 is out of range for type 'union acpi_operand_object *[9]'
CPU: 37 PID: 1678 Comm: cat Not tainted
6.0.0-dev-th500-6.0.y-1+bcf8c46459e407-generic-64k
HW name: NVIDIA BIOS v1.1.1-d7acbfc-dirty 12/19/2022 Call trace:
 dump_backtrace+0xe0/0x130
 show_stack+0x20/0x60
 dump_stack_lvl+0x68/0x84
 dump_stack+0x18/0x34
 ubsan_epilogue+0x10/0x50
 __ubsan_handle_out_of_bounds+0x80/0x90
 acpi_ds_exec_end_op+0x1bc/0x6d8
 acpi_ps_parse_loop+0x57c/0x618
 acpi_ps_parse_aml+0x1e0/0x4b4
 acpi_ps_execute_method+0x24c/0x2b8
 acpi_ns_evaluate+0x3a8/0x4bc
 acpi_evaluate_object+0x15c/0x37c
 acpi_evaluate_integer+0x54/0x15c
 show_power+0x8c/0x12c [acpi_power_meter]

Link: https://github.com/acpica/acpica/commit/90310989
Signed-off-by: Abhishek Mainkar <abmainkar@nvidia.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/psopcode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 28af49263ebfa..62957cba30f61 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
-			 AML_FLAGS_EXEC_0A_0T_1R),
+			 AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
 
 /* ACPI 5.0 opcodes */
 
-- 
2.40.1

