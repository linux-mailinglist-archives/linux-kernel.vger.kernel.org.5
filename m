Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0A759CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGSRso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4915C1FE8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689788875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foCsuTlaTYiUdT0EoYTewi4VWmF5exv07sKx0Z3C8eQ=;
        b=ZcSuv3Nwa+uIwaZ6rz23RgVjgKsaFSoze1k/K+MSRxd1pOjifcQKM6RaOCh5y60AwmeMoz
        DpCnP3YYHZuozt3YvSt+cPw5pTX/YBmiTRv7f4Ig+VtxBwCJigdabYlkfevpCROPenE4RO
        OUzlOzA5l5MoRZsFYe8BuTkFo+G1V1I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-xkW-L1d9OOmgSjrP5mDVdg-1; Wed, 19 Jul 2023 13:47:49 -0400
X-MC-Unique: xkW-L1d9OOmgSjrP5mDVdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58BDE2800174;
        Wed, 19 Jul 2023 17:47:48 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E962166B25;
        Wed, 19 Jul 2023 17:47:47 +0000 (UTC)
Date:   Wed, 19 Jul 2023 10:47:45 -0700
From:   Chris Leech <cleech@redhat.com>
To:     =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
Cc:     Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:ISCSI" <open-iscsi@googlegroups.com>,
        "open list:ISCSI" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] scsi: iscsi: kfree_sensitive() in iscsi_session_free()
Message-ID: <ZLghwZh2jVnLpzim@rhel-developer-toolbox-latest>
References: <20230719074534.5311-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230719074534.5311-1-duminjie@vivo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 07:45:48AM +0000, 杜敏杰 wrote:
> session might contain private part of the password, so better use
> kfree_sensitive() to free it.
> In iscsi_session_free() use kfree_sensitive() to free session->password,
> session->password_in, session->username, session->username_in.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

This looks good, thank you for the follow up to Mike's review.

Reviewed-by: Chris Leech <cleech@redhat.com>

> ---
>  drivers/scsi/libiscsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index 0fda8905e..a307da898 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3132,10 +3132,10 @@ void iscsi_session_free(struct iscsi_cls_session *cls_session)
>  	struct module *owner = cls_session->transport->owner;
>  
>  	iscsi_pool_free(&session->cmdpool);
> -	kfree(session->password);
> -	kfree(session->password_in);
> -	kfree(session->username);
> -	kfree(session->username_in);
> +	kfree_sensitive(session->password);
> +	kfree_sensitive(session->password_in);
> +	kfree_sensitive(session->username);
> +	kfree_sensitive(session->username_in);
>  	kfree(session->targetname);
>  	kfree(session->targetalias);
>  	kfree(session->initiatorname);
> -- 
> 2.39.0
> 

