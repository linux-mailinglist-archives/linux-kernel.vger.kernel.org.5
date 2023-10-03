Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F37B6EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjJCQmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbjJCQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:31:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64491;
        Tue,  3 Oct 2023 09:31:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 93AEA2B4;
        Tue,  3 Oct 2023 16:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 93AEA2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696350671; bh=Gehdcdnf+A4CsEvU65+tetDAgnqQs9RkmnesjHWCM08=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=Ohzgz7htoFlZeGQCP6pIrq1QIAoIxUyNPAZ2Feb+Hi7yqoYx+aJikuJWnzMibvfSx
         a9jMFb6bgTVBqyHPR4XipyfgQKbLhPzE2Vl4qia/GsE33wJv6hXwV41mSBbUkAjWbA
         3ukODpRmXqZGps2T7zYq2XmCqxJhCMG6hQPWY3L7lsNYBt6gBJwwc+cvSepXPJhGbV
         DbObOhDJkwdvzhghNBbIug1NACrIOVgjscJDDAVsHAAGq8o8sPa5MuTYSoUOOYk6ov
         s26wC8rFb76KSS8iDEoKPxHaplQzqRKKpaOpBB5MooD5IGd/in/Y7SgtcALyyKe6gd
         bjmcasDAeKFTg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Claudio Cambra <developer@claudiocambra.com>,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs: Fix Sphinx 8 warning caused by paths represented
 with strings
In-Reply-To: <5fd1b5cd-ea6c-44a1-9cb5-8f692d32ec99@infradead.org>
References: <20230924184057.91861-1-developer@claudiocambra.com>
 <5fd1b5cd-ea6c-44a1-9cb5-8f692d32ec99@infradead.org>
Date:   Tue, 03 Oct 2023 10:31:10 -0600
Message-ID: <87y1gjd5wx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
>
> On 9/24/23 11:40, Claudio Cambra wrote:
>> Running "make htmldocs" generates several lines of this warning:
>> 
>> Documentation/sphinx/kerneldoc.py:141: RemovedInSphinx80Warning: Sphinx 8 will drop support for representing paths as strings. Use "pathlib.Path" or "os.fspath" instead.
>>   doc = (env.srcdir + "/" + env.docname + ":" + str(self.lineno))
>> 
>> Making "doc" an fspath type and creating a new variable with the
>> appended colon and lineno fixes this warning.
>> 
>> Signed-off-by: Claudio Cambra <developer@claudiocambra.com>
>> ---
>>  Documentation/sphinx/kerneldoc.py | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
>> index 9395892c7ba3..e2c835e10dba 100644
>> --- a/Documentation/sphinx/kerneldoc.py
>> +++ b/Documentation/sphinx/kerneldoc.py
>> @@ -138,7 +138,8 @@ class KernelDocDirective(Directive):
>>                      lineoffset = int(match.group(1)) - 1
>>                      # we must eat our comments since the upset the markup
>>                  else:
>> -                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
>> +                    doc = os.path.join(env.srcdir, env.docname)
>> +                    doc_with_line = (doc + ":" + str(self.lineno))
>>                      result.append(line, doc + ": " + filename, lineoffset)
>>                      lineoffset += 1
>>  
>
> This patch should be sent to the linux-doc@vger.kernel.org mailing list,
> with the Documentation maintainer copied on the patch.
>
> We also have this similar patch to consider:
>   https://lore.kernel.org/linux-doc/20230910040811.53046-1-erer1243@gmail.com/

I have, in fact, applied that other patch.

Thanks,

jon
