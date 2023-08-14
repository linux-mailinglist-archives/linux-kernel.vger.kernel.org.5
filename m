Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DB77BB02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjHNOId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjHNOIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B2F10F7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692022061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Grht1UdEsF4WiLYP8/gvuchTHNIdp67lMPXt4Pailk=;
        b=YU5WwaanOkhhgGtFsU+8LmxoX5oesR2zVm3DSS4n79XUEsjIOCMguZOl964VLIGspJzmtg
        46EhNSloraEi17WYFeRshSgbuQE7Ns6ZLyolM4rqil6Xdw3ss1w+8Iq5ADPNG78yGNjiyK
        V9e/TFz28S9t1kvX+PG8IbN4HqrOy/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-yXZucHBoO0eU277vOj6KXA-1; Mon, 14 Aug 2023 10:07:37 -0400
X-MC-Unique: yXZucHBoO0eU277vOj6KXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68E238007A4;
        Mon, 14 Aug 2023 14:07:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id A154B2026D68;
        Mon, 14 Aug 2023 14:07:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Aug 2023 16:06:54 +0200 (CEST)
Date:   Mon, 14 Aug 2023 16:06:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Petr Skocik <pskocik@gmail.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: Fix the error return of kill -1
Message-ID: <20230814140652.GA30596@redhat.com>
References: <20221122161240.137570-1-pskocik@gmail.com>
 <202211220913.AF86992@keescook>
 <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
 <878rai7u0l.fsf@email.froward.int.ebiederm.org>
 <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
 <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
 <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

This change LGTM, but ...

On 08/11, Eric W. Biederman wrote:
>
> @@ -1602,7 +1603,8 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
>  		ret = __kill_pgrp_info(sig, info,
>  				pid ? find_vpid(-pid) : task_pgrp(current));
>  	} else {
> -		int retval = 0, count = 0;
> +		bool found = false, success = false;
> +		int retval = 0;
>  		struct task_struct * p;
>  
>  		for_each_process(p) {
> @@ -1610,12 +1612,12 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
>  					!same_thread_group(p, current)) {
>  				int err = group_send_sig_info(sig, info, p,
>  							      PIDTYPE_MAX);
> -				++count;
> -				if (err != -EPERM)
> -					retval = err;
> +				found = true;
> +				success |= !err;
> +				retval = err;
>  			}
>  		}
> -		ret = count ? retval : -ESRCH;
> +		ret = success ? 0 : (found ? retval : -ESRCH);

Why do we need the "bool found" variable ? Afacis

	} else {
		bool success = false;
		int retval = -ESRCH;
		struct task_struct * p;

		for_each_process(p) {
			if (task_pid_vnr(p) > 1 &&
					!same_thread_group(p, current)) {
				int err = group_send_sig_info(sig, info, p,
							      PIDTYPE_MAX);
				success |= !err;
				retval = err;
			}
		}
		ret = success ? 0 : retval;
	}

does the same?

Oleg.

