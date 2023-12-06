Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EE98075C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442645AbjLFQu6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 11:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442697AbjLFQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:50:41 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD61D69;
        Wed,  6 Dec 2023 08:50:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sljj71151zB0LnM;
        Thu,  7 Dec 2023 00:36:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
        by mail.maildlp.com (Postfix) with ESMTP id AF6CE140801;
        Thu,  7 Dec 2023 00:50:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3MnNLpnBlbvgJAg--.48489S2;
        Wed, 06 Dec 2023 17:50:32 +0100 (CET)
Message-ID: <795534ce04428d5cf6d64b8d6fc567a6d444ab5a.camel@huaweicloud.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 06 Dec 2023 17:50:16 +0100
In-Reply-To: <7aefd87764ba8962de85250ff92b82800550401b.camel@linux.ibm.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
         <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
         <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
         <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
         <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
         <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
         <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
         <CAHC9VhROnfBoaOy2MurdSpcE_poo_6Qy9d2U3g6m2NRRHaqz4Q@mail.gmail.com>
         <5f441267b6468b98e51a08d247a7ae066a60ff0c.camel@huaweicloud.com>
         <d608edb80efe03b62698ab33cbee1eea856a0422.camel@huaweicloud.com>
         <7aefd87764ba8962de85250ff92b82800550401b.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwD3MnNLpnBlbvgJAg--.48489S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF17AF18XF48Cw4rZr4UXFb_yoW5AFykpF
        y7KFWDJw4DAryjkrsayF45ZF40yrWSqFZ8Gr1Fkrn5Ar98Xr10qrWSyry5uFy3GrsYgay2
        vr4YkrnrZF1DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj5dSJwACsX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-06 at 11:11 -0500, Mimi Zohar wrote:
> On Wed, 2023-12-06 at 14:10 +0100, Roberto Sassu wrote:
> > On Mon, 2023-12-04 at 14:26 +0100, Roberto Sassu wrote:
> 
> ...
> > > If the result of this patch set should be that IMA and EVM become
> > > proper LSMs without the shared integrity layer, instead of collapsing
> > > all changes in this patch set, I think we should first verify if IMA
> > > and EVM can be really independent. Once we guarantee that, we can
> > > proceed making the proper LSMs.
> > > 
> > > These are the changes I have in mind:
> > > 
> > > 1) Fix evm_verifyxattr(), and make it work without integrity_iint_cache
> > > 2) Remove the integrity_iint_cache parameter from evm_verifyxattr(),
> > >    since the other callers are not going to use it
> > 
> > Ehm, I checked better.
> > 
> > integrity_inode_get() is public too (although it is not exported). So,
> > a caller (not IMA) could do:
> > 
> > iint = integrity_inode_get(inode);
> > status = evm_verifyxattr(..., iint);
> > 
> > However, it should not call integrity_inode_free(), which is also in
> > include/linux/integrity.h, since this is going to be called by
> > security_inode_free() (currently).

Oh, I needed to add a check for the iint here:


void integrity_inode_free(struct inode *inode)
{
	struct integrity_iint_cache *iint;

	if (!IS_IMA(inode))
		return;

	iint = integrity_iint_find(inode);
	if (!iint)                          <=== this
		return;

	integrity_inode_set_iint(inode, NULL);

	iint_free(iint);
}

> Calling integrity_inode_free() directly would release the iint early.  
> As a result, IMA would then need to re-allocate it on next access. 
> Other than impacting IMA's performance, is this a problem?

Uhm, I think the iint could be freed while IMA is using it, for example
in process_measurement().

Roberto

> > > 3) Create an internal function with the original parameters to be used
> > >    by IMA
> > > 4) Introduce evm_post_path_mknod(), which similarly to
> > >    ima_post_path_mknod(), sets IMA_NEW_FILE for new files
> > 
> > I just realized that also this is changing the current behavior.
> > 
> > IMA would clear IMA_NEW_FILE in ima_check_last_writer(), while EVM
> > wouldn't (unless we implement the file_release hook in EVM too).
> 
> True
> 
> Mimi
> 
> > > 5) Add hardcoded call to evm_post_path_mknod() after
> > >    ima_post_path_mknod() in security.c
> > > 
> > > If we think that this is good enough, we proceed with the move of IMA
> > > and EVM functions to the LSM infrastructure (patches v7 19-21).
> > > 
> > > The next patches are going to be similar to patches v6 22-23, but
> > > unlike those, their goal would be simply to split metadata, not to make
> > > IMA and EVM independent, which at this point has been addressed
> > > separately in the prerequisite patches.
> > > 
> > > The final patch is to remove the 'integrity' LSM and the integrity
> > > metadata management code, which now is not used anymore.
> > > 
> > > Would that work?
> > 
> > We are not making much progress, I'm going to follow any recommendation
> > that would move this forward.
> 

