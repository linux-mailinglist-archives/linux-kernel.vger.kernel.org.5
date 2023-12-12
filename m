Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC99E80F250
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjLLQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjLLQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:21:01 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C79D;
        Tue, 12 Dec 2023 08:21:04 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SqNm53fN9z9yB75;
        Wed, 13 Dec 2023 00:07:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
        by mail.maildlp.com (Postfix) with ESMTP id C6B8E1402E1;
        Wed, 13 Dec 2023 00:21:00 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDnInNgiHhltjNqAg--.30943S2;
        Tue, 12 Dec 2023 17:21:00 +0100 (CET)
Message-ID: <13be18b9-90d2-4535-a72e-40899d4063bd@huaweicloud.com>
Date:   Tue, 12 Dec 2023 17:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com,
        jlayton@kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
 <20231211-fortziehen-basen-b8c0639044b8@brauner>
 <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
 <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDnInNgiHhltjNqAg--.30943S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18Kr4kAF48XF48Zr17Awb_yoW5Kr1xpr
        ZIk3Z7KrZ8JF17A3sIy3W7uw4Fkr4rCFyUWr98Xr4kCFyDWFnIkrWay345uF17JFsaqw4j
        v3y2yr9rZr15Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj5ePYgAAsH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.23 11:44, Amir Goldstein wrote:
> On Tue, Dec 12, 2023 at 12:25 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>>
>> On 11.12.23 19:01, Christian Brauner wrote:
>>>> The second problem is that one security.evm is not enough. We need two,
>>>> to store the two different HMACs. And we need both at the same time,
>>>> since when overlayfs is mounted the lower/upper directories can be
>>>> still accessible.
>>>
>>> "Changes to the underlying filesystems while part of a mounted overlay
>>> filesystem are not allowed. If the underlying filesystem is changed, the
>>> behavior of the overlay is undefined, though it will not result in a
>>> crash or deadlock."
>>>
>>> https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-filesystems
>>>
>>> So I don't know why this would be a problem.
>>
>> + Eric Snowberg
>>
>> Ok, that would reduce the surface of attack. However, when looking at:
>>
>>        ovl: Always reevaluate the file signature for IMA
>>
>>        Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
>> i_version")
>>        partially closed an IMA integrity issue when directly modifying a file
>>        on the lower filesystem.  If the overlay file is first opened by a
>> user
>>        and later the lower backing file is modified by root, but the extended
>>        attribute is NOT updated, the signature validation succeeds with
>> the old
>>        original signature.
>>
>> Ok, so if the behavior of overlayfs is undefined if the lower backing
>> file is modified by root, do we need to reevaluate? Or instead would be
>> better to forbid the write from IMA (legitimate, I think, since the
>> behavior is documented)? I just saw that we have d_real_inode(), we can
>> use it to determine if the write should be denied.
>>
> 
> There may be several possible legitimate actions in this case, but the
> overall concept IMO should be the same as I said about EVM -
> overlayfs does not need an IMA signature of its own, because it
> can use the IMA signature of the underlying file.
> 
> Whether overlayfs reads a file from lower fs or upper fs, it does not
> matter, the only thing that matters is that the underlying file content
> is attested when needed.

Just some thoughts...

Ok, so we attest the lower/upper file. What about the path the 
application specified to access that file (just an example)? Not that it 
particularly matters (we are not protecting it yet), but we are not 
recording in the IMA measurement list what the application 
requested/sees. I don't have a good example for inode metadata, but we 
already started recording them too.

Also, I'm thinking about overlayfs-own xattrs. Shouldn't they be 
protected? If they change during an offline attack, it would change how 
information are presented by overlayfs (I don't know much, for now).

Roberto

> The only incident that requires special attention is copy-up.
> This is what the security hooks security_inode_copy_up() and
> security_inode_copy_up_xattr() are for.
> 
> When a file starts in state "lower" and has security.ima,evm xattrs
> then before a user changes the file, it is copied up to upper fs
> and suppose that security.ima,evm xattrs are copied as is?
> 
> When later the overlayfs file content is read from the upper copy
> the security.ima signature should be enough to attest that file content
> was not tampered with between going from "lower" to "upper".
> 
> security.evm may need to be fixed on copy up, but that should be
> easy to do with the security_inode_copy_up_xattr() hook. No?
> 
> Thanks,
> Amir.

