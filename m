Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BA76200E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGYR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGYR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD21BDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690305965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RfdbdDNr9lvtPioh6nTqIGvUGGU1L46kxvnNKym7qno=;
        b=Z3EWvYM5sMuFYjFP7y342mj5HjP50ALH07XTbPVHN2yQwJ+459gWvmMxVlifESvvR9ceov
        BYlgZVVIMpXiXXn+joRLHkUBq1bUHDT9ai9fYfZd1lYpdUgIdPn5VPs07IIowhJJ45vP4u
        fPqOyZ0iZK9nk3OzWC6lOpKXmu0vHHY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-OHXZMGCyMXOPHFdKEVYPvQ-1; Tue, 25 Jul 2023 13:26:03 -0400
X-MC-Unique: OHXZMGCyMXOPHFdKEVYPvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A8E51C09040;
        Tue, 25 Jul 2023 17:25:59 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39BB1200B66C;
        Tue, 25 Jul 2023 17:25:56 +0000 (UTC)
Date:   Tue, 25 Jul 2023 10:25:54 -0700
From:   Chris Leech <cleech@redhat.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     lduncan@suse.com, michael.christie@oracle.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, vikas.chaudhary@qlogic.com,
        JBottomley@parallels.com, mchan@broadcom.com, benli@broadcom.com,
        ogerlitz@voltaire.com, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scsi: iscsi: Add length check for nlattr payload
Message-ID: <ZMAFoszXQ3vwc9It@rhel-developer-toolbox-latest>
References: <20230725024529.428311-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725024529.428311-1-linma@zju.edu.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:45:29AM +0800, Lin Ma wrote:
> The current NETLINK_ISCSI netlink parsing loop checks every nlmsg to
> make sure the length is bigger than the sizeof(struct iscsi_uevent) and
> then calls iscsi_if_recv_msg(...).
> 
>   nlh = nlmsg_hdr(skb);
>   if (nlh->nlmsg_len < sizeof(*nlh) + sizeof(*ev) ||
>     skb->len < nlh->nlmsg_len) {
>     break;
>   }
>   ...
>   err = iscsi_if_recv_msg(skb, nlh, &group);
> 
> Hence, in iscsi_if_recv_msg, the nlmsg_data can be safely converted to
> iscsi_uevent as the length is already checked.
> 
> However, in the following parsing, the length of nlattr payload is never
> checked before the payload is converted to other data structures in some
> consumers. A bad one for example is function iscsi_set_path(...) who
> converts the payload to type iscsi_path without any checks.

Thank you for doing the code review on this, I think these changes look
good.

Reviewed-by: Chris Leech <cleech@redhat.com>

