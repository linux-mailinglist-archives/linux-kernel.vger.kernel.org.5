Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D507DC44D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjJaCMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJaCME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:04 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 233A5E8;
        Mon, 30 Oct 2023 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yaeF0
        1j6xShi/GTkQgI52Gfl0ZCLUkqjv+aPLffFlEc=; b=ADVavCjPJJWDEcu1w1HtR
        wBLQUHB/Nvy4eUgKX4lXSMCFaj8L6ztsGZAz535ybwB+v26FMMjE3ClmqnN07vHz
        kR0YHun62E8bn2R2MRXZMeCZn1Y89NyIIemzYqW4vAU8IpgE7hKNuK9/tY0iKdmm
        W4OuZ8dmAcl4SOqGrW4eRw=
Received: from localhost.localdomain (unknown [106.13.245.201])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3X9NSYkBlDPrVAA--.35827S2;
        Tue, 31 Oct 2023 10:11:39 +0800 (CST)
From:   Yusong Gao <a869920004@163.com>
To:     brauner@kernel.org
Cc:     a869920004@163.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH] fs: Fix typo in access_override_creds()
Date:   Tue, 31 Oct 2023 02:11:30 +0000
Message-Id: <20231031021130.855308-1-a869920004@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030-debatten-nachrangig-f58abcdac530@brauner>
References: <20231030-debatten-nachrangig-f58abcdac530@brauner>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X9NSYkBlDPrVAA--.35827S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4rJr47Kr4kJF18GFykKrg_yoWkKrc_ur
        40yr4xCrs8JFy0vwn09an0yF1Sg3yrAF18AFn7JrsI9r93Aas5ur98Kr93t398WF4xKr98
        Jrn5ZF9rZr4IvjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMYLv7UUUUU==
X-Originating-IP: [106.13.245.201]
X-CM-SenderInfo: zdywmmasqqiki6rwjhhfrp/xtbB0x8a6VXl17rCFAAAs0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At 2023-10-30 16:32:37, "Christian Brauner" <brauner@kernel.org> wrote:
>On Mon, Oct 30, 2023 at 01:52:35AM +0000, gaoyusong wrote:
>> From: Yusong Gao <a869920004@163.com>
>> 
>> Fix typo in access_override_creds(), modify non-RCY to non-RCU.
>> 
>> Signed-off-by: gaoyusong <a869920004@163.com>
>> ---
>>  fs/open.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/open.c b/fs/open.c
>> index 98f6601fbac6..72eb20a8256a 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -442,7 +442,7 @@ static const struct cred *access_override_creds(void)
>>  	 * 'get_current_cred()' function), that will clear the
>>  	 * non_rcu field, because now that other user may be
>>  	 * expecting RCU freeing. But normal thread-synchronous
>> -	 * cred accesses will keep things non-RCY.
>> +	 * cred accesses will keep things non-RCU.
>
>I think this might have been intended as a joke aka "non-RCY" as in
>"non-racy" here. I think best would be to change it to something like
>"cred accesses will keep things non-racy and allows to avoid rcu freeing"
>if you care enough.

I see what you mean. Thanks for your reply. I don't think any more
changes are needed when I figure out it.

