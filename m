Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D47B1043
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjI1BMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjI1BMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:12:08 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B1983BF;
        Wed, 27 Sep 2023 18:12:05 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 4ADCF6018F7FD;
        Thu, 28 Sep 2023 09:12:02 +0800 (CST)
Message-ID: <b1a6134d-f976-ed9d-aac0-06f3c93fc1c6@nfschina.com>
Date:   Thu, 28 Sep 2023 09:12:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ovl: avoid possible NULL dereference
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <f929f35e-2599-48e4-a77f-f2002bc94482@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/27 22:39, Dan Carpenter wrote:
> On Wed, Sep 27, 2023 at 05:02:26PM +0300, Amir Goldstein wrote:
>> On Mon, Sep 25, 2023 at 7:52 AM Su Hui <suhui@nfschina.com> wrote:
>>> smatch warn:
>>> fs/overlayfs/copy_up.c:450 ovl_set_origin() warn:
>>> variable dereferenced before check 'fh' (see line 449)
>>>
>>> If 'fh' is NULL, passing NULL instead of 'fh->buf'.
>>>
>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>> ---
>>>   fs/overlayfs/copy_up.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
>>> index d1761ec5866a..086f9176b4d4 100644
>>> --- a/fs/overlayfs/copy_up.c
>>> +++ b/fs/overlayfs/copy_up.c
>>> @@ -446,7 +446,7 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
>>>          /*
>>>           * Do not fail when upper doesn't support xattrs.
>>>           */
>>> -       err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh->buf,
>>> +       err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh ? fh->buf : NULL,
>>>                                   fh ? fh->fb.len : 0, 0);
>>>          kfree(fh);
>>>
>>> --
>>> 2.30.2
>> After discussing this with Dan Carpenter, this is not a kernel bug,
>> it is a smatch bug.
> Yeah.  Sorry about that, Su Hui.  The ->buf struct member is not a
> pointer, it's an array.  So this isn't really a dereference, it's just
> pointer math and foo = fh->buf won't crash even if fh is NULL.
Got it, I'm so careless that make this wrong patch.
Really thanks for your reminder!

Su Hui

>
> I have written a fix for this in Smatch.  I'll test it a bit before I
> push it.
>
> regards,
> dan carpenter
>
