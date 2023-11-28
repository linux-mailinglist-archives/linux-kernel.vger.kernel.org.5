Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74E97FC258
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjK1OHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345463AbjK1OHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:07:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC7B5;
        Tue, 28 Nov 2023 06:07:18 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DFD381F74C;
        Tue, 28 Nov 2023 14:07:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE2421343E;
        Tue, 28 Nov 2023 14:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id YJlRJhP0ZWXeNgAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 14:07:15 +0000
Date:   Tue, 28 Nov 2023 15:07:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tj@kernel.org, ying.huang@intel.com,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 02/11] mm/mempolicy: swap cond reference counting
 logic in do_get_mempolicy
Message-ID: <ZWX0Dq6_-0NAFgSl@tiehlicka>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-3-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122211200.31620-3-gregory.price@memverge.com>
X-Spamd-Bar: +++++++++++++++
X-Spam-Score: 15.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=fail (smtp-out2.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: DFD381F74C
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.63)[82.28%];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[19];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 16:11:51, Gregory Price wrote:
[...]
> @@ -982,11 +991,11 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  	}
>  
>   out:
> -	mpol_cond_put(pol);
> +	mpol_put(pol);
>  	if (vma)
>  		mmap_read_unlock(mm);
>  	if (pol_refcount)
> -		mpol_put(pol_refcount);
> +		mpol_cond_put(pol_refcount);

Maybe I am just misreading the patch but pol_refcount should be always
NULL with this patch

>  	return err;
>  }
>  
> -- 
> 2.39.1
> 

-- 
Michal Hocko
SUSE Labs
