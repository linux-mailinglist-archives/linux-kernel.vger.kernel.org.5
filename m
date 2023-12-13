Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96066811FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442269AbjLMUGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjLMUGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E43F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702497981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wamy6ZLjsCqbPaUGOHqCPQWdjqfo0kYV5q8insG9vzg=;
        b=b1ZPrJXkxczM1eX1uoJgCGOBaYF4chQ1K6ZRq6Qe8xs620eHxTXrXV5yY8TJmA1QA5iuz7
        KFlkUFozNy7uzet0PfJd+xH7/AaiBGk4+jWGqefs2vuLYkAURGwe+G4LF0aWAS6EcFCfGR
        GtacPyLX1bQQszeacGCXP9Pat6wdaZY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-eViGQ28KPNWBegcPkOC9Fw-1; Wed,
 13 Dec 2023 15:06:18 -0500
X-MC-Unique: eViGQ28KPNWBegcPkOC9Fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A06481C294A1;
        Wed, 13 Dec 2023 20:06:17 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.17.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B86B251E3;
        Wed, 13 Dec 2023 20:06:16 +0000 (UTC)
Date:   Wed, 13 Dec 2023 12:06:14 -0800
From:   Chris Leech <cleech@redhat.com>
To:     lduncan@suse.com
Cc:     target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dbond@suse.com, hare@suse.de,
        michael.christie@oracle.com
Subject: Re: [PATCH 1/2] scsi: target: iscsi: handle SCSI immediate commands
Message-ID: <ZXoOtgVZW_QpkU11@rhel-developer-toolbox-latest>
References: <cover.1701540918.git.lduncan@suse.com>
 <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:42:34AM -0800, lduncan@suse.com wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> Some iSCSI initiators send SCSI PDUs with the "immediate" bit
> set, and this is allowed according to RFC 3720. Commands with
> the "Immediate" bit set are called "immediate commands". From
> section 3.2.2.1. "Command Numbering and Acknowledging":
> 
>    The target MUST NOT transmit a MaxCmdSN that is less than
>    ExpCmdSN-1.  For non-immediate commands, the CmdSN field can take any
>    value from ExpCmdSN to MaxCmdSN inclusive.  The target MUST silently
>    ignore any non-immediate command outside of this range or non-
>    immediate duplicates within the range.  The CmdSN carried by
>    immediate commands may lie outside the ExpCmdSN to MaxCmdSN range.
>    For example, if the initiator has previously sent a non-immediate
>    command carrying the CmdSN equal to MaxCmdSN, the target window is
>    closed.  For group task management commands issued as immediate
>    commands, CmdSN indicates the scope of the group action (e.g., on
>    ABORT TASK SET indicates which commands are aborted).
> 
> This fixed an issue with fastlinq qedi Converged Network Adapter
> initiator firmware, trying to use an LIO target for booting. These
> changes made booting possible, with or without ImmediateData enabled.
> 
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> Reviewed-by: David Bond <dbond@suse.com>
> ---
>  drivers/target/iscsi/iscsi_target.c      | 12 +++---------
>  drivers/target/iscsi/iscsi_target_util.c | 10 ++++++++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 1d25e64b068a..f246e5015868 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -1060,13 +1060,6 @@ int iscsit_setup_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>  					     ISCSI_REASON_BOOKMARK_INVALID, buf);
>  	}
>  
> -	if (hdr->opcode & ISCSI_OP_IMMEDIATE) {
> -		pr_err("Illegally set Immediate Bit in iSCSI Initiator"
> -				" Scsi Command PDU.\n");
> -		return iscsit_add_reject_cmd(cmd,
> -					     ISCSI_REASON_BOOKMARK_INVALID, buf);
> -	}
> -
>  	if (payload_length && !conn->sess->sess_ops->ImmediateData) {
>  		pr_err("ImmediateData=No but DataSegmentLength=%u,"
>  			" protocol error.\n", payload_length);

This seems right, as the flag is checked again later in the same
function.

> @@ -1255,14 +1248,15 @@ int iscsit_process_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>  	/*
>  	 * Check the CmdSN against ExpCmdSN/MaxCmdSN here if
>  	 * the Immediate Bit is not set, and no Immediate
> -	 * Data is attached.
> +	 * Data is attached. Also skip the check if this is
> +	 * an immediate command.

This comment addition seems redundant, isn't that what the "Immediate
Bit is not set" already means?

>  	 *
>  	 * A PDU/CmdSN carrying Immediate Data can only
>  	 * be processed after the DataCRC has passed.
>  	 * If the DataCRC fails, the CmdSN MUST NOT
>  	 * be acknowledged. (See below)
>  	 */
> -	if (!cmd->immediate_data) {
> +	if (!cmd->immediate_data && !cmd->immediate_cmd) {
>  		cmdsn_ret = iscsit_sequence_cmd(conn, cmd,
>  					(unsigned char *)hdr, hdr->cmdsn);
>  		if (cmdsn_ret == CMDSN_ERROR_CANNOT_RECOVER)

Are you sure this needs to be checking both conditions here?  I'm
struggling to understand why CmdSN checking would be bypassed for
immediate data.  Is this a longstanding bug where the condition should
have been on immediate_cmd (and only immediate_cmd) instead?

Or is this because of the handling the immediate data with DataCRC case
mentioned?  I do see iscsit_sequence_cmd also being called in
iscsit_get_immediate_data.

- Chris Leech

