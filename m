Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E557F26CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjKUH6v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 02:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:58:48 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090CC3;
        Mon, 20 Nov 2023 23:58:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SZGcc6rRPz9y5Z0;
        Tue, 21 Nov 2023 15:45:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD35HQHY1xldiUUAQ--.11542S2;
        Tue, 21 Nov 2023 08:58:13 +0100 (CET)
Message-ID: <884eb5167283c7ce0604b3dae9807d99b661eff8.camel@huaweicloud.com>
Subject: Re: [PATCH v6 25/25] security: Enforce ordering of 'ima' and 'evm'
 LSMs
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 21 Nov 2023 08:57:56 +0100
In-Reply-To: <24a9f95d-6a28-47d3-a0cf-48e1698e2445@schaufler-ca.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
         <20231120173318.1132868-26-roberto.sassu@huaweicloud.com>
         <24a9f95d-6a28-47d3-a0cf-48e1698e2445@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwD35HQHY1xldiUUAQ--.11542S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DtFW5WFWfuFW3ZFWrXwb_yoW5CF18pa
        yqqFWfKF4kAryIgwn3Xay3WF1S93ykCF15Ar9xJw1UJ3yqvr1vkr4xtrWfuFyDJr1DCa4I
        vr42gw1fGws0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5atPwAAs4
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-20 at 16:50 -0800, Casey Schaufler wrote:
> On 11/20/2023 9:33 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > The ordering of LSM_ORDER_LAST LSMs depends on how they are placed in the
> > .lsm_info.init section of the kernel image.
> > 
> > Without making any assumption on the LSM ordering based on how they are
> > compiled, enforce that ordering at LSM infrastructure level.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/security.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/security/security.c b/security/security.c
> > index 351a124b771c..b98db79ca500 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -263,6 +263,18 @@ static void __init initialize_lsm(struct lsm_info *lsm)
> >  	}
> >  }
> >  
> > +/* Find an LSM with a given name. */
> > +static struct lsm_info __init *find_lsm(const char *name)
> > +{
> > +	struct lsm_info *lsm;
> > +
> > +	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++)
> > +		if (!strcmp(lsm->name, name))
> > +			return lsm;
> > +
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * Current index to use while initializing the lsm id list.
> >   */
> > @@ -333,10 +345,23 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> >  
> >  	/* LSM_ORDER_LAST is always last. */
> >  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> > +		/* Do it later, to enforce the expected ordering. */
> > +		if (!strcmp(lsm->name, "ima") || !strcmp(lsm->name, "evm"))
> > +			continue;
> > +
> 
> Hard coding the ordering of LSMs is incredibly ugly and unlikely to scale.
> Not to mention perplexing the next time someone creates an LSM that "has to be last".

Uhm, yes, not the best solution.

> Why isn't LSM_ORDER_LAST sufficient? If it really isn't, how about adding
> and using LSM_ORDER_LAST_I_REALLY_MEAN_IT* ?

I don't know if the order at run-time reflects the order in the
Makefile (EVM is compiled after IMA). If it does, there is no need for
this patch.

> Alternatively, a declaration of ordering requirements with regard to other
> LSMs in lsm_info. You probably don't care where ima is relative to Yama,
> but you need to be after SELinux and before evm. lsm_info could have 
> must_precede and must_follow lists. Maybe a must_not_combine list, too,
> although I'm hoping to make that unnecessary. 

Uhm, I agree. Will think about how to make it more straightforward.

> And you should be using LSM_ID values instead of LSM names.

Ok.

Thanks

Roberto

> ---
> * Naming subject to Paul's sensibilities, of course.
> 
> >  		if (lsm->order == LSM_ORDER_LAST)
> >  			append_ordered_lsm(lsm, "   last");
> >  	}
> >  
> > +	/* Ensure that the 'ima' and 'evm' LSMs are last and in this order. */
> > +	lsm = find_lsm("ima");
> > +	if (lsm)
> > +		append_ordered_lsm(lsm, "   last");
> > +
> > +	lsm = find_lsm("evm");
> > +	if (lsm)
> > +		append_ordered_lsm(lsm, "   last");
> > +
> >  	/* Disable all LSMs not in the ordered list. */
> >  	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
> >  		if (exists_ordered_lsm(lsm))

