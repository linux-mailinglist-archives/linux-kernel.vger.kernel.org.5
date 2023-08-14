Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8269877B896
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjHNM0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHNM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:26:21 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 05:26:19 PDT
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF53DF5;
        Mon, 14 Aug 2023 05:26:19 -0700 (PDT)
Received: from pirotess (80.red-83-50-209.dynamicip.rima-tde.net [83.50.209.80])
        by iodev.co.uk (Postfix) with ESMTPSA id 8FBCA208939;
        Mon, 14 Aug 2023 14:26:18 +0200 (CEST)
Date:   Mon, 14 Aug 2023 14:26:16 +0200
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andrey Utkin <andrey_utkin@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 17/25] media: solo6x10: Convert to generic PCM copy ops
Message-ID: <ZNodaGnVsOkt3vje@pirotess>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-18-tiwai@suse.de>
 <ZNoa1jU7O08KwOJ6@pirotess>
 <87350l3jix.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87350l3jix.wl-tiwai@suse.de>
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/Aug/2023 14:17, Takashi Iwai wrote:
> On Mon, 14 Aug 2023 14:15:18 +0200,
> Ismael Luceno wrote:
> > 
> > On 14/Aug/2023 13:55, Takashi Iwai wrote:
> > > This patch converts the solo6x10 driver code to use the new unified
> > > PCM copy callback.  It's a straightforward conversion from *_user() to
> > > *_iter() variants.  As copy_to_iter() updates the internal offest at
> > > each write, we can drop the dst counter update in the loop, too.
> > > 
> > > Note that copy_from/to_iter() returns the copied bytes, hence the
> > > error condition is inverted from copy_from/to_user().
> > > 
> > > Cc: Bluecherry Maintainers <maintainers@bluecherrydvr.com>
> > > Cc: Anton Sviridenko <anton@corp.bluecherry.net>
> > > Cc: Andrey Utkin <andrey_utkin@fastmail.com>
> > > Cc: Ismael Luceno <ismael@iodev.co.uk>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: linux-media@vger.kernel.org
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/media/pci/solo6x10/solo6x10-g723.c | 38 +++-------------------
> > >  1 file changed, 5 insertions(+), 33 deletions(-)
> > > 
> > > diff --git a/drivers/media/pci/solo6x10/solo6x10-g723.c b/drivers/media/pci/solo6x10/solo6x10-g723.c
> > > index 6cebad665565..aceacb822cab 100644
> > > --- a/drivers/media/pci/solo6x10/solo6x10-g723.c
> > > +++ b/drivers/media/pci/solo6x10/solo6x10-g723.c
> > > @@ -204,9 +204,9 @@ static snd_pcm_uframes_t snd_solo_pcm_pointer(struct snd_pcm_substream *ss)
> > >  	return idx * G723_FRAMES_PER_PAGE;
> > >  }
> > >  
> > > -static int snd_solo_pcm_copy_user(struct snd_pcm_substream *ss, int channel,
> > > -				  unsigned long pos, void __user *dst,
> > > -				  unsigned long count)
> > > +static int snd_solo_pcm_copy(struct snd_pcm_substream *ss, int channel,
> > > +			     unsigned long pos, struct iov_iter *dst,
> > > +			     unsigned long count)
> > >  {
> > >  	struct solo_snd_pcm *solo_pcm = snd_pcm_substream_chip(ss);
> > >  	struct solo_dev *solo_dev = solo_pcm->solo_dev;
> > > @@ -223,35 +223,8 @@ static int snd_solo_pcm_copy_user(struct snd_pcm_substream *ss, int channel,
> > >  		if (err)
> > >  			return err;
> > >  
> > > -		if (copy_to_user(dst, solo_pcm->g723_buf, G723_PERIOD_BYTES))
> > > +		if (!copy_to_iter(solo_pcm->g723_buf, G723_PERIOD_BYTES, dst))
> > >  			return -EFAULT;
> > > -		dst += G723_PERIOD_BYTES;
> > > -	}
> > > -
> > > -	return 0;
> > > -}
> > > -
> > > -static int snd_solo_pcm_copy_kernel(struct snd_pcm_substream *ss, int channel,
> > > -				    unsigned long pos, void *dst,
> > > -				    unsigned long count)
> > > -{
> > > -	struct solo_snd_pcm *solo_pcm = snd_pcm_substream_chip(ss);
> > > -	struct solo_dev *solo_dev = solo_pcm->solo_dev;
> > > -	int err, i;
> > > -
> > > -	for (i = 0; i < (count / G723_FRAMES_PER_PAGE); i++) {
> > > -		int page = (pos / G723_FRAMES_PER_PAGE) + i;
> > > -
> > > -		err = solo_p2m_dma_t(solo_dev, 0, solo_pcm->g723_dma,
> > > -				     SOLO_G723_EXT_ADDR(solo_dev) +
> > > -				     (page * G723_PERIOD_BLOCK) +
> > > -				     (ss->number * G723_PERIOD_BYTES),
> > > -				     G723_PERIOD_BYTES, 0, 0);
> > > -		if (err)
> > > -			return err;
> > > -
> > > -		memcpy(dst, solo_pcm->g723_buf, G723_PERIOD_BYTES);
> > > -		dst += G723_PERIOD_BYTES;
> > >  	}
> > >  
> > >  	return 0;
> > > @@ -263,8 +236,7 @@ static const struct snd_pcm_ops snd_solo_pcm_ops = {
> > >  	.prepare = snd_solo_pcm_prepare,
> > >  	.trigger = snd_solo_pcm_trigger,
> > >  	.pointer = snd_solo_pcm_pointer,
> > > -	.copy_user = snd_solo_pcm_copy_user,
> > > -	.copy_kernel = snd_solo_pcm_copy_kernel,
> > > +	.copy = snd_solo_pcm_copy,
> > >  };
> > >  
> > >  static int snd_solo_capture_volume_info(struct snd_kcontrol *kcontrol,
> > > -- 
> > > 2.35.3
> > > 
> > 
> > Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> 
> You meant Reviewed-by or Acked-by?  Signed-off-by is a tag used when
> you carry a patch.
> 
> 
> thanks,
> 
> Takashi

Yes, sorry, I meant "Acked-by".
