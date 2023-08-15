Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3077CEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjHOPNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbjHOPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A7F1737
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692112360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODUqpL2Gc/JjVPIf9U4xLWMrwUjIK6qonM7TlbOBrGQ=;
        b=Furou9bpXQ2nyEJUtQ/tLFUDLTPVu82+Y23hRsfcKp2BArWIKPzTdHo2S2PwwBOthXfDXz
        CHwz/mH8Fp9Ge5p26Uew3kvyeqbRBEbCiOQr9PJx2eVG4omu0QES0aH4xunBVTttQ8Ap0o
        wjGIISRiVLab+aZVdSJ4vSMpOePuNhY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-JPy1p-zoPiS0BaMnfNlUzw-1; Tue, 15 Aug 2023 11:12:36 -0400
X-MC-Unique: JPy1p-zoPiS0BaMnfNlUzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A20313810D3B;
        Tue, 15 Aug 2023 15:12:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.75])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB37363F7A;
        Tue, 15 Aug 2023 15:12:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Aug 2023 17:11:53 +0200 (CEST)
Date:   Tue, 15 Aug 2023 17:11:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Skocik <pskocik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: Fix the error return of kill -1
Message-ID: <20230815151149.GA29072@redhat.com>
References: <20221122161240.137570-1-pskocik@gmail.com>
 <202211220913.AF86992@keescook>
 <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
 <878rai7u0l.fsf@email.froward.int.ebiederm.org>
 <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
 <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
 <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
 <20230814140652.GA30596@redhat.com>
 <20230814154351.GA4203@redhat.com>
 <3b14ae8091e3403bbc4ef1bee6dcf4f6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b14ae8091e3403bbc4ef1bee6dcf4f6@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, David Laight wrote:
>
> or maybe even:
> 	} else {
> 		struct task_struct * p;
> 		int err;
> 		ret = -ESRCH;
>
> 		for_each_process(p) {
> 			if (task_pid_vnr(p) > 1 &&
> 					!same_thread_group(p, current)) {
> 				err = group_send_sig_info(sig, info, p,
> 							  PIDTYPE_MAX);
> 				if (ret)
> 					ret = err;

Hmm, indeed ;)

and "err" can be declared inside the loop.

Oleg.

